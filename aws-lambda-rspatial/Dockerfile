FROM jsinghm/aws-lambda-r:latest

# Install udunits2
RUN apk --no-cache add wget expat-dev gcc musl-dev g++ \
    && wget https://artifacts.unidata.ucar.edu/repository/downloads-udunits/2.2.28/udunits-2.2.28.tar.gz \
    && tar xf udunits-2.2.28.tar.gz \
    && cd udunits-2.2.28/ \
    && ./configure --prefix=/usr \
    && make \
    && make install \
    && cd ../ \
    && rm -r udunits-2.2.28/ \
    && rm udunits-2.2.28.tar.gz \
    && apk --no-cache del wget gcc musl-dev g++

# Install `sf`
RUN installr -d \
             -a "geos-dev proj-dev proj-util gdal-dev gdal-tools netcdf-dev" \
             -t "gfortran openssl-dev sqlite-dev linux-headers" \
             raster RNetCDF sf terra
