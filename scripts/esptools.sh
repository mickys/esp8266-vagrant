#!/usr/bin/env bash

if [ -f /vagrant/options ]; then
	echo "reading options"
	. /vagrant/options
fi

if [ -f esptool_0.0.2-1_i386.deb ]; then
	cd $DOWNLOADS
	wget -O esptool_0.0.2-1_i386.deb https://github.com/esp8266/esp8266-wiki/raw/master/deb/esptool_0.0.2-1_i386.deb
	dpkg -i esptool_0.0.2-1_i386.deb
fi


if [ ! -d "$BASE_FOLDER/esptool-py" ]; then
	cd $BASE_FOLDER
	git clone https://github.com/themadinventor/esptool esptool-py
	ln -s $PWD/esptool-py/esptool.py crosstool-NG/builds/xtensa-lx106-elf/bin/
fi