handlebars = require 'handlebars'
Waller = require './waller'
fs = require 'fs'
$ = require 'jquery'

conf = JSON.parse fs.readFileSync './conf.json', 'utf8'
waller = new Waller conf

source = $('#imageTemplate').html()
template = handlebars.compile source

container = $('#container')
grid =
	x: container.width() / 100
	y: container.height() / 100

waller.getUserLikes waller.likes[0], (likes) =>
	for like in likes
		waller.getProjectInfo like.slug, () =>
			

			result = template like
			$('#col' + i++ % 3).append result

	# result = template
	# 	likes: likes
	#
	# container.append result
