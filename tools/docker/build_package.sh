#!/bin/bash

if [ ! -d "/pkg" ]; then
    echo "This script should not be run outside of the Docker container"
    exit 1
fi

git clone git://github.com/paperManu/splash
cd splash
git submodule update --init

if [ -d "build" ]; then
    rm -rf build
fi
mkdir build && cd build

cmake ..
make -j$(nproc) && make package

if [ ! -f splash-*.deb ]; then
    echo "The package has not been built, an error seems to have occured"
    exit 1
else
    cp splash-*.deb /pkg
fi
