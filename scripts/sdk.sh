#!/usr/bin/env bash

BASE_FOLDER=/project
SDK_FOLDER=$BASE_FOLDER/ESP8266_SDK
DOWNLOADS=/vagrant/downloads

if [ -f /vagrant/options ]; then
	echo "reading options"
	. /vagrant/options
fi

echo "sdk"
if [ ! -f "$DOWNLOADS/esp_iot_sdk_v0.9.2_14_10_24.zip" ]; then
	echo "download first"
	wget -O $DOWNLOADS/esp_iot_sdk_v0.9.2_14_10_24.zip http://bbs.espressif.com/download/file.php?id=1		
fi
cd $BASE_FOLDER
unzip $DOWNLOADS/esp_iot_sdk_v0.9.2_14_10_24.zip
mv $BASE_FOLDER/esp_iot_sdk_v0.9.2 $SDK_FOLDER

#fixing some execute bits
chmod +x $SDK_FOLDER/app/*.sh
chmod +x $SDK_FOLDER/tools/*.py