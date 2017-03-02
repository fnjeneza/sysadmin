#!/bin/bash

BRANCH=v8.0.0398

cd /tmp
git clone -b $BRANCH  https://github.com/vim/vim.git
cd vim
./configure --prefix=$HOME/.local --with-features=huge --enable-python3interp
make -j5 && make install
