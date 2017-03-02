#!/bin/bash

echo "llvm installation"

set -e

VERSION=3.9.1
LLVM=llvm-$VERSION
CLANG=cfe-$VERSION
CLANG_EXTRA=clang-tools-extra-$VERSION
LLVM_ARCHIVE=$LLVM.src.tar.xz
CLANG_ARCHIVE=$CLANG.src.tar.xz
PREFIX=$HOME/.local
GCC_PREFIX=$HOME/.local
NB_CPU=`cat /proc/cpuinfo | grep processor | wc -l`

cd /tmp
wget http://releases.llvm.org/$VERSION/$LLVM_ARCHIVE
tar xvf $LLVM_ARCHIVE

wget http://releases.llvm.org/$VERSION/$CLANG_ARCHIVE
tar xvf CLANG_ARCHIVE
mv $CLANG.src $LLVM.src/tools/clang

wget http://releases.llvm.org/$VERSION/$CLANG_EXTRA.src.tar.xz
tar xvf $CLANG_EXTRA.src.tar.xz
mv $CLANG_EXTRA.src $LLVM.src/tools/clang/extra

mkdir /tmp/build && cd /tmp/build

export LD_LIBRARY_PATH=$GCC_PREFIX/lib64/:$GCC_PREFIX/lib/:$LD_LIBRARY_PATH

cmake -G ninja
	-DCMAKE_BUILD_TYPE=release \
	-DPYTHON_EXECUTABLE=$PREFIX/bin/python3.6 \
	-DCMAKE_CXX_COMPILER=$PREFIX/bin/g++  \
	-DCMAKE_C_COMPILER=$PREFIX/bin/gcc \
	-DCMAKE_INSTALL_PREFIX=$PREFIX \
	/tmp/$LLVM.src/

ninja && ninja install
