module.exports = () ->
	nwService = require('node-windows').Service

	serv = new nwService
		name: 'Waller'
		description: 'Waller\'s wallpaper update service'
		script: __dirname + '\\main.js'

	serv.on 'install', () ->
		serv.start()

	serv.on 'error', (err) ->
		console.log 'error? ' + err

	console.log 'file: ' + __dirname + '\\main.js'
	serv.install()
