#!/bin/bash

cd /tmp
wget https://github.com/vim/vim/archive/v8.0.0567.zip
unzip v8.0.0567.zip
cd vim-8.0.0567/
./configure --prefix=$HOME/.local/
	--with-features=huge \
	--enable-python3interp=dynamic \
	--enable-cscope \
	--enable-gui=no \
	--enable-fail-if-missing \

make -j5 && make install
