# Sounding Attention Labour with Critical Debugging

> The past years of technological development has seen a growing distrust in the tools that are used in everyday life. The commodification of human attention in data extractivism is going under more attentive scrutiny from governments around the world.The general awareness of this technological failures has been brought forward, not only by academics but also artists and designers who challenge the technological given, by exerting their right to critique. During the workshop the method of debugging will be subverted from technical error correction to a forensic tool to spot the site of data extraction. The latter will then be sonified and performed in the evening as an ensemble. During the 6 hours workshop the group will have time to discuss the relationship between interface, labour and attention economy, engage with technical skills like network debugging with the firefox built-in tools, as well as the basics of modular sound design with VCV rack.

## Requirements

1. [Processing 4](https://processing.org) with `Simple HTTP Server` and `MidiBus` libraries installed
2. [VCV Rack 2](https://vcvrack.com/) with this [delay](https://library.vcvrack.com/AlrightDevices/Chronoblob2), this [reverb](https://library.vcvrack.com/Valley/Plateau), [distortion](https://library.vcvrack.com/VultModulesFree/Debriatus) and [sound module](https://library.vcvrack.com/squinkylabs-plug1/squinkylabs-super)
3. [Firefox](https://www.mozilla.org/en-US/firefox/new/)

## Setting up MIDI on mac or Windows

Follow this [instruction](https://help.ableton.com/hc/en-us/articles/209774225-Setting-up-a-virtual-MIDI-bus)

1. Go to `Applications` => `Utilities` => `Audio MIDI Setup.app`
2. click on `Window` => `Show MIDI Studio`
3. now you should have a list of all MIDI devices connected to the machine one of those should be called: `IAC Driver` that is your virtual MIDI device. Click on it!
4. Set the device as online, if you want rename the MIDI interface.

## Setting up MIDI on Windows && linux

Download [this](https://www.tobias-erichsen.de/software/loopmidi.html) for Windows
For linux follow  this [tutorial](https://www.local-guru.net/blog/2018/11/10/connecting-linux-midi-programs-using-alsa-virtual-midi)

## Adding custom extensions to Firefox

1. in the url bar type `about:debugging`
2. on the left side bar click `this Firefox`
3. Click on `Load Temporary Add-on`
4. search for the extension, in our case is inside the folder `web-extension`, the file to be added is the `manifest.json`, this will take care aof loading all the necessary files, as well scoping the extension to target specific urls as well as defining the permissions of the extension.

## Adding new modules to VCV Rack

1. go to [VCV Rack Website](https://vcvrack.com/)
2. create an account
3. search for the needed module and click the `Add` button
4. to add them to the software you need to do the login from the software as well
