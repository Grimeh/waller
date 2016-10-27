request = require 'request'
fs = require 'fs'
async = require 'async'
path = require 'path'

# consts
base = "https://www.artstation.com/"
artwork = "projects/"
users = "users/"
likes = "likes.json"
likesPerPage = 50.0
likedProjectsCount = "liked_projects_count"

module.exports =
	class Waller
		constructor: (config) ->
			# Username
			@usernames = config.usernames
			# Where to download images to
			@savePath = config.savePath
			# Print debug info
			@debug = config.debug
			# Max no. downloaded images (0 = unlimited)
			@limit = config.limit

			@done = false

		getJson: (url, callback) ->
			if @debug
				console.log 'json req: ' + url

			request
				url: url
				json: true
				, (err, resp, body) ->
					if @debug
						console.log 'json resp: ' + resp + ':' + body
					callback body

		getProjectInfo: (projectSlug, callback) ->
			@getJson base + artwork + projectSlug + '.json', callback

		getUserInfo: (user, callback) ->
			@getJson base + users + user + '.json', callback

		getUserLikePage: (user, page, callback) ->
			# Get page #[page] of [user]'s likes
			url = base + users + user + '/' + likes + '?page=' + page

			@getJson url, (resp) =>
				callback resp.data

		getUserLikes: (user, callback) ->
			@getUserInfo user, (resp) =>
				# limit the number of projects we consider
				count = resp.liked_projects_count
				count = Math.min(count, @limit) if @limit > 0
				# how many pages do we need to fetch
				numPages = Math.ceil(count / likesPerPage)

				# queue up our requests
				queue = new Array()
				makeGet = (user, page) =>
					return (callback) =>
						@getUserLikePage user, page, (resp) =>
							callback null, resp

				for i in [0...numPages]
					queue.push makeGet user, i

				if @debug
					console.log 'user likes: ' + queue.length

				async.parallelLimit queue, 5, (err, results) ->
					result = new Array()
					for x in results
						result = result.concat x
					callback result

		saveImage: (url, savePath) ->
			if @debug
				console.log 'saving image: ' + savePath
			req = request url
			req.pipe fs.createWriteStream savePath

		downloadProjectImage: (projectHash) ->
			@getProjectInfo projectHash, (projInfo) =>
				asset = null
				for x in projInfo.assets when x.has_image
					asset = x
					break

				if not x?
					console.log 'Error: Could not find suitable image asset for project ' + projInfo.title
					return null

				# get rid of illegal chars
				projInfo.title = projInfo.title.replace /\/|\\/g, "-"
				projInfo.title = projInfo.title.replace /\"/g, ""
				projInfo.title = projInfo.title.replace /\'/g, ""
				projInfo.title = projInfo.title.replace /\?/g, ""

				# extract file extension
				ext = x.image_url.match(/(\.[A-z][A-z][A-z])\?/)[1]
				projInfo.title += ext

				savePath = path.format
					dir: @savePath
					base: projInfo.title

				@saveImage x.image_url, savePath

		downloadAllUserLikes: () ->
			for user in @usernames
				@getUserLikes user, (likes) =>
					like = likes[0]
					@downloadProjectImage like.hash_id
