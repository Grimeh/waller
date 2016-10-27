waller = require './waller.js'
fs = require 'fs'

conf = JSON.parse fs.readFileSync './conf.json', 'utf8'

wall = new waller conf
wall.downloadAllUserLikes()
