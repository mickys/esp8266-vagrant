#!/usr/bin/env bash

PREFIX=/opt/xtensa-lx106-elf

if [ ! -d "$BASE_FOLDER/crosstool-NG" ]; then
	cd $BASE_FOLDER
	git clone -b lx106 git://github.com/jcmvbkbc/crosstool-NG.git 
fi


chown -R vagrant:vagrant $BASE_FOLDER
su vagrant << EOF
	cd $BASE_FOLDER/crosstool-NG
	./bootstrap && ./configure --prefix=$PREFIX && make && make install
	./ct-ng xtensa-lx106-elf
	./ct-ng build
EOF
