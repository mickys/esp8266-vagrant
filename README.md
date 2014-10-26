esp8266-vagrant
===============

This is a vagrant virtual mashine that "should" be able to
run a ESP8266 sdk and compiler. Much like the one provided
at http://bbs.espressif.com but more based on 
https://github.com/esp8266/esp8266-wiki/wiki/Toolchain

You will need vagrant + virtualbox installed.
It's not tested on anything but Linux at the moment
but should work wherever vagrant can be installed


Instructions
============

* Clone the esp8266-vagrant project into something like
  `esp8266-vagrant`
* set the environment variable ESPPROJECT to the folder where
  you want your project to live. If you don't do this it will be 
  in ../project
* run `vagrant up` to get things started
* run `vagrant ssh` to log on to the machine

After you have logged in to the virtual machine do the following

````bash
#go to the right place
cd /project/ESP8266_SDK/app

#copy a sample to the app folder
cp -R ../examples/IoT_Demo/* .

#this will build everything
#no need for running make first since 
#it's one of the first things in the file
./gen_misc.sh
````



Filesystem layout
=================

/opt/xtensa-lx106-elf		- compiler (on path)
/project					- maps to the project folder you decided on
/project/ESP8266_SDK		- extracted SDK
