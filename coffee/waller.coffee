request = require 'request'
fs = require 'fs'

base = "https://www.artstation.com/"
artwork = "projects/"
collections = "collections/"
users = "users/"
likes = "/likes.json"

module.exports =
	class Waller
		constructor: (@config) ->
			@likes = @config.likes
			@savePath = @config.savePath
			@collections = @config.collections

		getJson: (url, callback) ->
			request
				url: url
				json: true
				, (err, resp, body) ->
					callback body

		downloadUserLikes: (user) ->
			this.getJson base + users + user + likes, (resp) =>
				for like in resp.data
					this.getJson base + artwork + like.slug + '.json', (json) =>
						req = request(json.assets[0].image_url)
						json.title = json.title.replace /\/|\\/g, "-"
						req.pipe fs.createWriteStream this.savePath + '\\' + json.title + '.jpg'

		downloadAllUserLikes: () ->
			for like in @likes
				this.downloadUserLikes like

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
