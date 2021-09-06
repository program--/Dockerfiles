#!/bin/bash

# Install GDAL
echo "Installing GDAL"
cd /tmp
wget https://github.com/OSGeo/gdal/releases/download/v$GDAL_VERSION/gdal-$GDAL_VERSION.tar.gz
tar -xvf gdal-$GDAL_VERSION.tar.gz
cd gdal-$GDAL_VERSION
CFLAGS="-g -Wall" LDFLAGS="-s" ./configure \
                               --with-png=internal \
                               --with-libtiff=internal \
                               --with-geotiff=internal \
                               --with-jpeg=internal \
                               --with-gif=internal \
                               --with-ecw=no \
                               --with-expat=yes \
                               --with-sqlite3=yes \
                               --with-geos=yes \
                               --with-libz=internal \
                               --with-threads=yes \
                               --with-xerces=yes

make -j 2 && make install
make check && ldconfig
echo "\n${bold}GDAL Installed${normal}\n"

cd /tmp
rm gdal-$GDAL_VERSION.tar.gz
rm -r gdal-$GDAL_VERSION

echo "GDAL: $(gdalinfo --version)"
exit 0