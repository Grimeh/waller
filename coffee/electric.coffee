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
		width: 800
		height: 400
		frame: false
	mainWindow.loadURL "file://#{__dirname}/index.html"
	mainWindow.webContents.openDevTools()
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
	conf.limit = arg.limit
	conf.savePath = arg.savePath
	conf.usernames[0] = arg.username

	waller = new Waller global.conf
	waller.downloadAllUserLikes () =>
		event.sender.send 'done'
