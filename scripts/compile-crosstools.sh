#!/usr/bin/env bash


if [ -f /vagrant/options ]; then
	echo "reading options"
	. /vagrant/options
fi


if [ ! -d "$BASE_FOLDER/crosstool-NG" ]; then
	cd $BASE_FOLDER
	git clone -b lx106 git://github.com/jcmvbkbc/crosstool-NG.git 
fi


chown -R vagrant:vagrant $BASE_FOLDER
if [ ! -d "$BASE_FOLDER/crosstool-NG/builds/xtensa-lx106-elf" ]; then
su vagrant << EOF
	cd $BASE_FOLDER/crosstool-NG
	./bootstrap && ./configure --prefix=`pwd` && make && make install
	./ct-ng xtensa-lx106-elf
	./ct-ng build
	echo "export PATH=$PWD/builds/xtensa-lx106-elf/bin:\$PATH" >> /home/vagrant/.profile
EOF
fi