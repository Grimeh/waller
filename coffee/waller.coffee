request = require 'request'
fs = require 'fs'
async = require 'async'

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
			@getJson base + artwork + slug + '.json', callback

		getUserInfo: (user, callback) ->
			@getJson base + users + user + '.json', callback

		getUserLikePage: (user, page, callback) ->
			# Get page #[page] of [user]'s likes
			url = base + users + user + '/' + likes + '?page=' + page

			@getJson url, (resp) =>
				callback resp.data

		getUserLikes: (user, callback) ->
			@getUserInfo user, (resp) =>
				numPages = Math.ceil(resp.liked_projects_count / likesPerPage)
				queue = new Array()
				makeGet = (user, page) =>
					return (callback) =>
						@getUserLikePage user, page, (resp) =>
							callback null, resp

				for i in [0...numPages]
					queue.push makeGet user, i

				console.log 'user likes: ' + queue.length
				async.parallelLimit queue, 5, (err, results) ->
					result = new Array()
					for x in results
						result = result.concat x
					callback result

				# this.getUserLikes user, (resp) =>
				# 	for like in resp
				# 		@getJson base + artwork + like.slug + '.json', (json) =>
				# 			req = request(json.assets[0].image_url)
				# 			json.title = json.title.replace /\/|\\/g, "-"
				# 			json.title = json.title.replace /\"/g, ""
				# 			json.title = json.title.replace /\'/g, ""
				# 			json.title = json.title.replace /\?/g, ""
				# 			console.log 'Saving image: ' + json.title
				# 			req.pipe fs.createWriteStream this.savePath + '\\' + json.title + '.jpg'

		downloadAllUserLikes: () ->
			for user in @usernames
				this.getUserLikes user, (likes) ->
					# TODO download images with async
