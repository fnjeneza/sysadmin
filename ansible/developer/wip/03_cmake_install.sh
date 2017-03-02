#!/bin/bash

cd /tmp
wget https://cmake.org/files/v3.7/cmake-3.7.2.tar.gz
tar xvf cmake-3.7.2.tar.gz
cd cmake-3.7.2
./bootstrap --prefix=$HOME/.local
make -j5 && make install
