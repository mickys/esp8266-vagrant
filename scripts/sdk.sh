#!/usr/bin/env bash

# BASE_FOLDER=/project
# SDK_FOLDER=$BASE_FOLDER/ESP8266_SDK
# DOWNLOADS=/vagrant/downloads

if [ -f /vagrant/options ]; then
	echo "reading options"
	. /vagrant/options
fi


SDKARCHIVE=esp_iot_sdk_v0.9.2_14_10_24.zip

echo "sdk"
if [ ! -f "$DOWNLOADS/$SDKARCHIVE" ]; then
	echo "download first"
	wget -O $DOWNLOADS/$SDKARCHIVE http://bbs.espressif.com/download/file.php?id=9		
fi

if [ ! -d "$SDK_FOLDER" ]; then
	cd $BASE_FOLDER
	unzip $DOWNLOADS/$SDKARCHIVE
	mv $BASE_FOLDER/esp_iot_sdk_v0.9.2 $SDK_FOLDER

	cd $SDK_FOLDER
	wget -O lib/libc.a https://github.com/esp8266/esp8266-wiki/raw/master/libs/libc.a
	wget -O lib/libhal.a https://github.com/esp8266/esp8266-wiki/raw/master/libs/libhal.a
	wget -O include.tgz https://github.com/esp8266/esp8266-wiki/raw/master/include.tgz
	tar -xvzf include.tgz

	#fixing some execute bits
	chmod +x $SDK_FOLDER/app/*.sh
	chmod +x $SDK_FOLDER/tools/*.py

	cd $SDK_FOLDER
	sed -i -e 's/xt-ar/xtensa-lx106-elf-ar/' -e 's/xt-xcc/xtensa-lx106-elf-gcc/' -e 's/xt-objcopy/xtensa-lx106-elf-objcopy/' Makefile
fi

if [ ! -d "$SDK_FOLDER/examples/at_v0.19_on_SDKv0.9.2" ]; then
	cd $SDK_FOLDER
	wget -O $DOWNLOADS/at_v0.19_14_10_30.zip http://bbs.espressif.com/download/file.php?id=13
	unzip $DOWNLOADS/at_v0.19_14_10_30.zip
	# cd at_v0.19_on_SDKv0.9.2
	# make
fi