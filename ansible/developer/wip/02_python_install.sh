#!/bin/bash

VER=3.6
VERSION=$VER.0
PREFIX=$HOME/.local
NB_CPU=`cat /proc/cpuinfo | grep processor | wc -l`

cd /tmp
wget https://www.python.org/ftp/python/$VERSION/Python-$VERSION.tar.xz
tar xvf Python-$VERSION.tar.xz
cd Python-$VERSION
./configure --prefix=$PREFIX --enable-shared
make -j$NB_CPU && make altinstall

cd $PREFIX/bin
ln -s python$VER python3
