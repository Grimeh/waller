request = require 'request'
fs = require 'fs'

base = "https://www.artstation.com/"
artwork = "projects/"
collections = "collections/"
users = "users/"
likes = "likes.json"

module.exports =
	class Waller
		constructor: (config) ->
			@likes = config.likes
			@savePath = config.savePath
			@collections = config.collections
			@debug = config.debug

		getJson: (url, callback) ->
			if @debug
				console.log 'json req: ' + url

			request
				url: url
				json: true
				, (err, resp, body) ->
					callback body

		getUserLikes: (user, callback, page = 1, appendTo = null) ->
			this.getJson base + users + user + '/' + likes + '?page=' + page, (resp) =>
				if appendTo?
					appendTo.data.push.apply appendTo.data, resp.data
					console.log 'appended length: ' + appendTo.data.length
				else
					appendTo = resp
					console.log 'initial page'

				# console.log 'page: ' + page + ', total: ' + resp.total_count
				if page * 50 >= resp.total_count
					callback appendTo.data
				else
					this.getUserLikes user, callback, page + 1, appendTo

		downloadUserLikes: (user) ->
			# this.getJson base + users + user + likes, (resp) =>
			this.getUserLikes user, (resp) =>
				for like in resp
					this.getJson base + artwork + like.slug + '.json', (json) =>
						req = request(json.assets[0].image_url)
						json.title = json.title.replace /\/|\\/g, "-"
						json.title = json.title.replace /\"/g, ""
						json.title = json.title.replace /\'/g, ""
						json.title = json.title.replace /\?/g, ""
						console.log 'Saving image: ' + json.title
						req.pipe fs.createWriteStream this.savePath + '\\' + json.title + '.jpg'

		downloadAllUserLikes: () ->
			for like in @likes
				this.downloadUserLikes like

		getProjectInfo: (projectSlug, callback) ->
			getJson base + artwork + slug + '.json', callback

		# downloadCollection: (collection) ->
		# 	console.log 'resp: ' + base + collections + collection + '.json'
		# 	this.getJson base + collections + collection + '.json', (resp) =>
		# 		console.log 'resp: ' + resp
		# 		for project in resp.projects
		# 			this.getJson base + artwork + project.slug + '.json', (json) =>
		# 				req = request(json.assets[0].image_url)
		# 				req.pipe fs.createWriteStream this.savePath + '\\' + json.title + '.jpg'
		#
		# downloadAllCollections: () ->
		# 	for collection in @collections
		# 		this.downloadCollection collection
