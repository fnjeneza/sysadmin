#!/bin/bash

cd /tmp
wget https://www.samba.org/ftp/ccache/ccache-3.3.4.tar.bz2
tar xvf ccache-3.3.4.tar.bz2
cd ccache-3.3.4

./configure --prefix=$HOME/.local
make && make install

