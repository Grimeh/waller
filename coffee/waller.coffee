request = require 'request'
fs = require 'fs'
nSchedule = require 'node-schedule'

base = "https://www.artstation.com/"
artwork = "projects/"
users = "users/"
likes = "/likes.json"

savePath = 'C:\\Users\\Brandon\\wallpapers'

getJson = (url, callback) ->
	request
		url: url
		json: true
		, (err, resp, body) ->
			callback body

module.exports =
	user: 'Grimeh'

	readConfig: (configFile) ->
		conf = JSON.parse fs.readFileSync configFile, 'utf8'
		user = conf.user
		savePath = conf.savePath

	update: () ->
		getJson base + users + this.user + likes, (resp) ->
			for like in resp.data
				getJson base + artwork + like.slug + '.json', (json) ->
					console.log 'getting ' + json.assets[0].image_url
					request(json.assets[0].image_url).pipe(fs.createWriteStream savePath + '\\' + json.title + '.jpg') .on 'close', () ->
						console.log 'saved'

	schedule: (minutes) ->
		nSchedule.scheduleJob minutes + ' * * * *', () ->
			update()
