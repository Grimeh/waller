install = require './windows.js'
waller = require './waller.js'

for arg in process.argv
	if arg is 'install'
		install()
	# else if arg is 'run'
	# 	waller.update()
	# 	waller.schedule()

waller.update()
waller.schedule()
