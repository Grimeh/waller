fs = require 'fs'
$ = require 'jquery'
electron = require 'electron'

# populate field with current config
conf = electron.remote.getGlobal 'conf'

$('#usernameInput').val conf.username
$('#limitInput').val conf.limit
$('#saveDirInput').val conf.savePath

# main process comms
ipcRenderer = electron.ipcRenderer
ipcRenderer.on 'savePathUpdated', (event, arg) =>
	$('#saveDirInput').val conf.savePath

ipcRenderer.on 'done', (event, arg) =>
	console.log 'DOWNLOADING COMPLETED'

$('#saveDirBrowseButton').on 'click', () ->
	ipcRenderer.send 'browse'

$('#beginButton').on 'click', () ->
	ipcRenderer.send 'download',
		username: $('#usernameInput').val()
		limit: $('#limitInput').val()
		savePath: $('#saveDirInput').val()


# close button callback
$('#closeButton').on 'click', () ->
	console.log 'closing window'
	window.close()
