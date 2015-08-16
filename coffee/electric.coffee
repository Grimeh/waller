app = require 'app'
BrowserWindow = require 'browser-window'
fs = require 'fs'
Waller = require './waller'

require('crash-reporter').start()

conf = JSON.parse fs.readFileSync './conf.json', 'utf8'
waller = new Waller conf

window = null

app.on 'windows-all-closed', () ->
	app.quit()

app.on 'ready', () ->
	window = new BrowserWindow
		width: 800
		height: 600

	window.loadUrl 'file://' + __dirname + '/index.html'

	window.on 'closed', () ->
		window = null;
