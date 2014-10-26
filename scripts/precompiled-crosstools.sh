#!/usr/bin/env bash
echo "precompiled-crosstools"

DOWNLOADS=/vagrant/downloads
COMPILER_ARCHIVE=xtensa-lx106-elf.tar.gz2
COMPILER_URL="https://drive.google.com/uc?id=0B5bwBE9A5dBXT0plVndobnU1dTg&export=download"

if [ ! -d /opt/xtensa-lx106-elf ]; then
	wget -O $DOWNLOADS/$COMPILER_ARCHIVE $COMPILER_URL
	cd /opt
	tar -jxvf $DOWNLOADS/$COMPILER_ARCHIVE
	echo "export PATH=/opt/xtensa-lx106-elf/bin:\$PATH" >> /home/vagrant/.profile
fi
