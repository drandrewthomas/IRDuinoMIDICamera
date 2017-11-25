# Arduino infrared camera in a web page using WebMIDI

## What is this project

Basically, this project is based around an Arduino infrared camera using the excellent AdaFruit AMG8833 8 by 8 sensor-matrix module. But, by using WebMIDI to interface over USB, you can view the data in modern web-browsers as a Web App. And, because WebMIDI works on many mobile browsers you should be able to use it on your tablet or smartphone, as well as on Linux, OSX and Windows! Below is a picture of the Web App running in the Chrome web-browser (it's a selfie, in case you wonder what I look like).


![alt text](https://github.com/drandrewthomas/IRDuinoMIDICamera/blob/master/Images/ircamera.jpg "An of the IR data saved from the Web App")

## Building your camera

The Arduino circuit is very simple, and all you have to do is connect the four wires for power, ground and I2C bus to the AdaFruit AMG8833 module. The AdaFruit AMG8833 page does an excellent job of explaining that, so just follow the hookup advice at this link:

[https://www.adafruit.com/product/3538]

## Programming the Arduino camera

Once you've built your camera, and tested it with some of the AdaFruit example code, you can upload the code in the Arduino ( [http://arduino.cc] ) folder in this repository. That's no different to uploading any other Arduino program, but remember to add the AdaFruit AMG8833 library to the Arduino IDE: you can find it at the above link.

You can do that on the Arduino online code editor too if you prefer: that's what I did and I have to say I was very impressed by what Arduino have done with cloud editing. When I coded this the AdaFruit library wasn't included in the IDE, so I had to upload it to my account first.

The Arduino code uses the USB-MIDI library. In case you don't know, Arduino USB-MIDI only works on compatible devices. Basically, you need an Arduino with a USB-connected microcontroller. Any Arduino with an Atmel 32u4 chip should work: I used a Genuino Micro which did the job very well.

## Setting up the Web App

You'll find three files in the WebFiles folder in this repository. Copy them to a folder on your website together with a copy of Processing.js ( [http://processingjs.org] ). If you need to, rename the Processing.js file to simply 'processing.js', as if the download has a slightly different name the app won't work.

Now, plug your IR camera into your USB port and go to http://YOURDOMAIN/YOURFOLDER in a modern web-browser. If all went well you should now see the web-app running in a webpage on your website.

If you want to know a bit more about the Web App files, basically we have 'index.html', which is a simple web page to include the Processing.js canvas in. You don't have to use it, you could instead take the relevant lines from it and add them to your own web page.

'amg8833.js' is a simple JavaScript file I wrote to interface the Web App to the browser-based WebMIDI API. I based it on a JavaScript class I was playing with in the past for interfacing to USB-MIDI instruments, so I thought I'd use it for this too. However, you could easily adapt the Web App to use another MIDI library.

'ircamera.pde', if you're not familiar with Processing, is the main Web App file. It's written in the Java-based Processing ( [http://www.processing.org] ) language, which is open-source and ideal for creating online and cloud projects like this one.

## Using the IR camera

The Web App is very simple, and hopefully it's obvious how to use it. Mostly it shows the 64 infrared pixels as a simple heatmap, which should update a few times a second at most. There are also three buttons you can click. The top one allows you to toggle whether numbers are drawn for tempeatures in the matrix.

Just below it is a button that lets you swap the horizontal direction of pixel drawing: usually you'd set it to normal, but when doing a selfie you use this button to swap left and right. At the bottom is a save button: click it and you can download an image of the Web App to look at later.

## What else can we do with this?

Having an infrared camera is a lot of fun, and I think having one that displays the data in a web-browser is extra-fun. However, there's a lot more you could do with this project if you like coding. Probably the most exciting would be to add a video feed from your webcam (or phone/tablet camera). You could then put the camera image in the background and add alpha to the temperature colours.

And, as the app works in a webpage, it's quite easy to get Processing.js to send the temperature array to a script on your website. The script could then analyse the data for you and save it for future use. Also, you could write code to save the temperature array to an array of arrays, and then send the data to a script on your website that creates a video file, or animated GIF, for you.

Finally, don't forget that WebMIDI wasn't created for infrared cameras. It was created for music and there's no reason why you shouldn't modify the code here to create a musical instrument where notes are based on temperature. Basically, the uses are only limited by our imaginations, so I hope you have fun with this project.

## Why use WebMIDI anyway?

I've been playing with interfacing microcontrollers to programs I write for many years. Sometimes that's been over USB (originally it was using RS232 cables - remember them?), sometimes wirelessly including WiFi and Bluetooth. So for a PC program I might use serial over USB, and for an Android app I'd mostly use Bluetooth.

But, those approaches aren't so good for web pages. Yes, there are USB and Bluetooth browser initiatives gaining pace, but having played with them I didn't feel they were robust enough for me to code this app to work on all my PCs, tablets and phone. However, having played with WebMIDI in the past I knew it would work.

## Credits

This project wouldn't have been possible without the AMG8833 module I bought from AdaFruit (and only four days from the United States to my home in the United Kingdom!):

[https://www.adafruit.com]

And, of course, who can forget the excellent Processing.js, which most of the Web App is based on:

[http://processingjs.org]

Plus, I couldn't have written this app without the excellent Arduino USB-MIDI library:

[https://github.com/arduino-libraries/MIDIUSB]

