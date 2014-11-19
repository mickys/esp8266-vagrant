#!/usr/bin/env bash


DOWNLOADS=/vagrant/downloads

echo "bootstrapping"


if [ -f /vagrant/options ]; then
	echo "reading options"
	. /vagrant/options
fi

export BASE_FOLDER
export SDK_FOLDER
export DOWNLOADS


chmod +x /vagrant/scripts/*.sh

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
		texinfo libtool libncurses5-dev wget gawk libc6-dev-amd64 \
		python-serial libexpat-dev
fi

#prepare some folders
echo "prepping some folders"
sudo mkdir -p $BASE_FOLDER 


#download and extract the SDK if missing
if [ ! -d "$SDK_FOLDER" ]; then
	/vagrant/scripts/sdk.sh
fi


#compile or not compile?
if [ $PRECOMPILED_CROSSTOOLS -eq 1 ]; then
	/vagrant/scripts/precompiled-crosstools.sh
else
	/vagrant/scripts/compile-crosstools.sh
fi

/vagrant/scripts/esptools.sh

