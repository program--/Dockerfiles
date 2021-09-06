#!/bin/bash

# Install GEOS
echo "Installing GEOS"
cd /tmp
wget http://download.osgeo.org/geos/geos-$GEOS_VERSION.tar.bz2
bunzip2 geos-$GEOS_VERSION.tar.bz2
tar -xvf geos-$GEOS_VERSION.tar
cd geos-$GEOS_VERSION
./configure && make -j 2 && make install
make check && ldconfig
echo "GEOS Installed"

cd /tmp
rm geos-$GEOS_VERSION.tar
rm -r geos-$GEOS_VERSION

echo "GEOS: $(geos-config --version)"
exit 0