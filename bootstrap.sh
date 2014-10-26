#!/usr/bin/env bash

BASE_FOLDER=/opt/Espressif
SDK_FOLDER=$BASE_FOLDER/ESP8266_SDK
CT_FOLDER=/opt/xtensa-lx106-elf



apt-get update
apt-get upgrade

#install some tools that will be needed
sudo apt-get install git autoconf build-essential gperf bison flex \
	texinfo libtool libncurses5-dev wget gawk libc6-dev-i386


#prepare some folders
sudo mkdir -p $BASE_FOLDER 
sudo chown -R $USER:$USER $BASE_FOLDER
mkdir -p $CT_FOLDER


#download and extract the SDK
wget -O $BASE_FOLDER/esp_iot_sdk_v0.9.2_14_10_24.zip http://bbs.espressif.com/download/file.php?id=1
unzip $BASE_FOLDER/esp_iot_sdk_v0.9.2_14_10_24.zip
mv $BASE_FOLDER/esp_iot_sdk_v0.9.2 $SDK_FOLDER


#add some libraries
wget -O $SDK_FOLDER/lib/libc.a https://github.com/esp8266/esp8266-wiki/raw/master/libs/libc.a
wget -O $SDK_FOLDER/lib/libhal.a https://github.com/esp8266/esp8266-wiki/raw/master/libs/libhal.a