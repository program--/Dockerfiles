#!/bin/bash

# Install PROJ
echo "\n${bold}Installing PROJ${normal}\n"
cd /tmp
wget https://download.osgeo.org/proj/proj-$PROJ_VERSION.tar.gz
tar -xvf proj-$PROJ_VERSION.tar.gz
cd proj-$PROJ_VERSION
./configure && make -j 4 && make install
make check && ldconfig
echo "\n${bold}PROJ Installed${normal}\n"

cd /tmp
rm proj-$PROJ_VERSION.tar.gz
rm -r proj-$PROJ_VERSION

echo "PROJ: $(proj 2>&1 | head -n 1)"
exit 0