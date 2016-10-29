electron = require 'electron'
fs = require 'fs'
Waller = require './waller'

app = electron.app
BrowserWindow = electron.BrowserWindow
dialog = electron.dialog

global.conf = JSON.parse fs.readFileSync './conf.json', 'utf8'

mainWindow = null

createWindow = =>
	mainWindow = new BrowserWindow
		width: 370
		height: 170
		resizable: false
		frame: false
	mainWindow.loadURL "file://#{__dirname}/index.html"
	# mainWindow.webContents.openDevTools()
	mainWindow.on 'closed', =>
		mainWindow = null

app.on 'ready', createWindow

app.on 'windows-all-closed', =>
	app.quit()

app.on 'activate', =>
	if not mainWindow?
		createWindow()

ipcMain = electron.ipcMain
ipcMain.on 'browse', (event, arg) =>
	dialog.showOpenDialog mainWindow,
		properties: ['openDirectory']
		, (filePaths) =>
			if filePaths?
				global.conf.savePath = filePaths[0]
			event.sender.send 'savePathUpdated'

ipcMain.on 'download', (event, arg) =>
	# update config
	global.conf.limit = arg.limit
	global.conf.savePath = arg.savePath
	global.conf.username = arg.username
	fs.writeFileSync './conf.json', JSON.stringify global.conf, 'utf-8'

	# display progress
	mainWindow.loadURL "file://#{__dirname}/progress.html"
	mainWindow.setSize 370, 60, true

	global.waller = new Waller global.conf
	global.waller.downloadAllUserLikes () =>
		mainWindow.close() # should close app
