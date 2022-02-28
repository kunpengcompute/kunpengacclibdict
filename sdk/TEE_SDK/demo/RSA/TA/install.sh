#!/bin/bash
if [ $# != 2 ]; then
    echo "Parameter should contain signed_config and TA_cert."
    exit 1
fi

cd cloud

# copy signed_config and TA_cert
cp -r $1 .
cp -r $2 .

# build
mkdir build
cd build
cmake ..
make
cd ..

# install
if [ ! -d"/data" ]; then
    mkdir -p /data
fi

if [ ! -x "" ]; then
    rm -rf /data/f68fd704-6eb1-4d14-b218-722850eb3ef0.sec
fi

cp f68fd704-6eb1-4d14-b218-722850eb3ef0.sec /data

# clean temp file
rm -rf build
rm -rf *.sec
rm -rf libcombine.so
rm -rf manifest.txt
rm -rf signed_config
rm -rf TA_cert
cd ..
