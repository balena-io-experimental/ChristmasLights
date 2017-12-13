# Pull in some libraries
# This one controls the LED string
# Note to self: this library uses GPIO 18 by default
Leds = require('rpi-ws281x-native')
# This one allows easy colour translation
Colour = require('color')
# This one allows easy common use structures
_ = require('lodash')

# Initialise the simple parts of the environment
numLeds = parseInt(process.env.LED_COUNT, 10) || 240
Leds.init(numLeds, {})
Leds.setBrightness(parseInt(process.env.LED_BRIGHTNESS, 10) || 32)
pixels = []
colourPace = parseInt(process.env.COLOUR_PACE ? '3')
colourInterval = parseInt(process.env.COLOUR_INTERVAL ? '20')

# Initialise an array of white LEDs
_.times numLeds, ->
	white = { h: 0, s: 0, l: 50 }
	pixels.push({ hsl: white, rgb: Colour(white).rgbNumber() })

# Regularly push the LED array to the string
render = ->
	Leds.render(_.map(pixels, (value) -> value.rgb))
setInterval(render, 1000 / 30)

# Pick a random pixel, if available, and start it's fade
initAnimation = ->
	pixel = _.sample(_.filter(pixels, (pixel) -> pixel.hsl.s == 0))
	if pixel?
		pixel.hsl.h = _.random(360)
		loopAnimation(pixel)
setInterval(initAnimation, colourInterval)

# Progress the fade one notch, then note to repeat this in a bit
loopAnimation = (pixel, progress = 0) ->
	progress += colourPace
	pixel.hsl.s = Math.max(100 - Math.abs(progress - 100), 0)
	pixel.hsl.h = (pixel.hsl.h + colourPace) % 360
	pixel.rgb = Colour(pixel.hsl).rgbNumber()
	if progress < 200
		next = _.partial(loopAnimation, pixel, progress)
		setTimeout(next, 1000 / 30)
