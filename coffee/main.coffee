waller = require './waller.js'
fs = require 'fs'

conf = JSON.parse fs.readFileSync './conf.json', 'utf8'

wall = new waller conf
# wall.downloadAllCollections()
wall.downloadAllUserLikes()

time = if conf.timer? then conf.timer else -1

if time is -1 or time is 0
	console.log "CONF.TIME NOT SET, RUNNING ONCE"
	return
else
	setInterval () =>
		wall.downloadAllUserLikes()
	, time * 1000
