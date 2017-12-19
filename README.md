# Christmas Lights!

Well, it was a Hack Friday on Dec 1st, and I had this spare string of WS2812 NeoPixel LEDs.  What happened next is obvious.

![lights](/media/lights.jpg)

Except I didn't have time to write it up, so here I am keeping a weekend eye on support and writing up my new Christmas lights.  I also promised to ping @sonyagreen when I published, because she wants a set, and will hopefully have better pictures.

## Expected behaviour

1) The LEDs should initialise to all white.
1) LEDs should fade to a colour and then back to white.

## I used

### Hardware

* A string of WS2812 lights.
  * I used [these](https://www.amazon.co.uk/gp/product/B01CFTBESA/) because they were on special offer when I bought them.
* An [RPi Zero W](https://shop.pimoroni.com/products/raspberry-pi-zero-w).
* An [RPi power supply](https://shop.pimoroni.com/products/raspberry-pi-universal-power-supply).
  * With a bit of cunning this ought to be redundant.
* A [hammer header](https://shop.pimoroni.com/products/gpio-hammer-header), because I wanted to try it.
  * Really easy if you don't want to solder.
  * Doesn't feel as sturdy as a well soldered header.
* [Some leads and breadboard](https://shop.pimoroni.com/products/maker-essentials-mini-breadboards-jumper-jerky)
  * I used some that I had in my bits drawer, but that pack looks like a really good starter kit.
  * With a bit of cunning this ought to be redundant.
* [A microSD card](https://shop.pimoroni.com/products/noobs-16gb-microsd-card).
* An independant power supply, to provide power to the LEDs.
  * I used one that I bought from Maplin about 10 years ago.
  * [This one](https://shop.pimoroni.com/products/5v-3a-barrel-jack-power-supply) looks quite likely to be suitable.
* A Chinese takeaway, in a plastic container.  (takeaway of choice may be substituted)

### Software

* My standard IOT toolchain.
  * [resin.io](https://resin.io/)
  * [etcher](https://etcher.io/)

### Time

* Half a Hack Friday on Dec 1st.
* Not quite enough time to write it up.

## Installation

1) While performing the following, dispose of the Chinese food.
1) Create a new app in your [resin.io](https://resin.io/) account.
1) Download and [etch](https://etcher.io/) the resinOS for this app.
1) Clone [this repo](https://github.com/resin-io-playground/ChristmasTree) into that app, git has several ways to do this.
1) Insert the microSD.
1) Wire it up, power it up and test it.
   * The RPi Zero takes long enough to boot to make me nervous, so wait a little while.
1) Wash and dry the plastic food carton, cut a slot in it, and box the electronics.

### Wiring

The wiring for this project is really easy.

* [BCM/GPIO 18](https://pinout.xyz/) (library default) to Data In of the WS2812 string.
* Connect the +ve of the power supply to the string.
* Connect the 0v of the supply to both the string and the Pi.
  * This is the only bit that actually needed the breadboard.
  * Might be able to go through the ground pins of the Pi, but I had breadboard knocking around.

### Programming

Programming was also fairly simple.  My thanks to some great libraries.  If you're just cloning my project you don't need to read this.

1) `require` the three libraries.
   * [rpi-ws281x-native](https://www.npmjs.com/package/rpi-ws281x-native)
   * [color](https://www.npmjs.com/package/color) 
   * [lodash](https://www.npmjs.com/package/lodash)
1) parse the `process.env` and initialise some globals and libraries.
1) populate `pixels` (an array tracking the LEDs) with white.
1) set up a render loop to push each LEDs `rgb` value to the library.
1) start a LED fading every once in a while.
1) actually handle each step of the fade.

### Troubleshooting

* The lights are flickering randomly!
  * The supply voltage for the LEDs might be too high. (wait a moment, this does make sense!).
    The Pi signals at 3.3v, which must be over 70% of the supplied voltage to get a clean signal. This means the supply can go up to 4.7v. Shops will often say the LEDs run off 5v, but the WS2812B technical specification lists 3.5v to 5.3v.  Somewhere a smidge over 4v should be perfect.
* The Pi shuts down randomly!
  * I had this problem until I put the LED string onto its own power supply. You might get away without the independant power supply, you might not. Depends on too many factors for me to predict, when in doubt don't use the Pi to power beefy projects.
  
## What next?

* Deploy a fleet across the resin.io team.
* Use a proto-hat to solder the connections properly.
* See if I can do it without the breadboard.
* See if I can do it with only one plug in the wall.
