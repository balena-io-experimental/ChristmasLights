Christmas Lights!
==

Well, it was a Hack Friday on Dec 1st, and I had this spare string of WS2812 NeoPixel LEDs.  What happened next is obvious.

![lights](/img/lights.jpg)

Except I didn't have time to write it up, so here I am keeping a weekend eye on support and writing up my new Christmas lights.  I also promised to ping @sonyagreen when I published, because she wants a set, and will hopefully have better pictures.

I used
--

* A string of WS2812 lights.
* A Hack Friday on Dec 1st.
* An RPi Zero Wireless and a PiBow case.
* Not quite enough time to write it up.
* resin.io, etcher, etc. My standard IOT toolchain.
* The rpi-ws281x-native, color and lodash npm libraries.

Wiring
--

The wiring for this project is really easy.

* GPIO 18 (library default) to Data In of the WS2812 string
* An independant 3.3v power supply to provide the amperage
* Connect the +ve of the power supply to the string
* Share the 0v of the power supply with the Pi

Software
--

The software was also fairly simple.  My thanks to some great libraries.

* The top block imports the three libraries
* Then I parse the environment and initialise some global variables and library bits
* Then I populate the internal array representing the LED string with white
* Then I set up a render loop that simply pushes the relevant part of the array to the library
* Then I start the fade of a LED every once in a while
* Then I deal with each step of the fade
