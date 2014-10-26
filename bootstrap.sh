#!/usr/bin/env bash

BASE_FOLDER=/project
SDK_FOLDER=$BASE_FOLDER/ESP8266_SDK

CT_FOLDER=/opt/xtensa-lx106-elf
PRECOMPILED_CROSSTOOLS=1
DOWNLOADS=/vagrant/downloads

echo "bootstrapping"


if [ -f /vagrant/options ]; then
	echo "reading options"
	. /vagrant/options
fi


#ubuntu basics
export DEBIAN_FRONTEND=noninteractive

#if we already have created the base folder
#this is probably done as well

if [ ! -f "/usr/bin/unzip" ]; then
	apt-get update
	apt-get upgrade
	apt-get install -y unzip

	#install some tools that will be needed
	#sudo apt-get install git autoconf build-essential gperf bison flex \
	#	texinfo libtool libncurses5-dev wget gawk libc6-dev-i386

	apt-get install -y git autoconf build-essential gperf bison flex \
		texinfo libtool libncurses5-dev wget gawk libc6-dev-amd64
fi

#prepare some folders
echo "prepping some folders"
sudo mkdir -p $BASE_FOLDER 


#download and extract the SDK
if [ ! -d "$SDK_FOLDER" ]; then
	echo "sdk"
	if [ ! -f "$DOWNLOADS/esp_iot_sdk_v0.9.2_14_10_24.zip" ]; then
		echo "download first"
		wget -O $DOWNLOADS/esp_iot_sdk_v0.9.2_14_10_24.zip http://bbs.espressif.com/download/file.php?id=1
		
	fi
	cd $BASE_FOLDER
	unzip $DOWNLOADS/esp_iot_sdk_v0.9.2_14_10_24.zip
	mv $BASE_FOLDER/esp_iot_sdk_v0.9.2 $SDK_FOLDER
fi


#add some libraries
if [ ! -f "$SDK_FOLDER/lib/libc.a" ]; then
	echo "doing libs"
	wget -O $SDK_FOLDER/lib/libc.a https://github.com/esp8266/esp8266-wiki/raw/master/libs/libc.a
	wget -O $SDK_FOLDER/lib/libhal.a https://github.com/esp8266/esp8266-wiki/raw/master/libs/libhal.a
fi


#headers
if [ ! -d "$BASE_FOLDER/include" ]; then
	echo "headers"
	if [ ! -f $DOWNLOADS/include.tgz ]; then
		echo "download first"
		wget -O $DOWNLOADS/include.tgz https://github.com/esp8266/esp8266-wiki/raw/master/include.tgz
	fi
	cd $BASE_FOLDER
	tar -xvzf $DOWNLOADS/include.tgz
fi


#compile or not compile?
if [ $PRECOMPILED_CROSSTOOLS -eq 1 ]; then
	/vagrant/scripts/precompiled-crosstools.sh
else
	/vagrant/scripts/compile-crosstools.sh
fi
