electron = require 'electron'
waller = electron.remote.getGlobal 'waller'

progressCanvas = document.getElementById 'progressCanvas'
context = progressCanvas.getContext '2d'

primaryColour = '#3F51B5';
accentColour = '#69F0AE';

canvasWidth = 300
canvasHeight = 20

draw = () =>
	fillAmount = Math.floor canvasWidth * waller.progress
	console.log 'fill: ' + fillAmount

	context.fillStyle = primaryColour
	context.fillRect fillAmount, 0, canvasWidth - fillAmount, canvasHeight

	context.fillStyle = accentColour
	context.fillRect 0, 0, fillAmount, canvasHeight

	context.font = '30px munro small'
	context.textAlign = 'center'
	context.fillText "DOWNLOADING", 150, 18, 300

	window.requestAnimationFrame draw

window.requestAnimationFrame draw
