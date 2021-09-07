FROM python:3.8-alpine as builder

RUN apk update \
    && apk upgrade \
    && apk add --no-cache build-base \
        autoconf \
        bash \
        bison \
        boost-dev \
        cmake \
        flex \
        libressl-dev \
        zlib-dev

RUN pip install --no-cache-dir six pytest numpy cython
RUN pip install --no-cache-dir pandas

ARG ARROW_VERSION=5.0.0
ARG ARROW_BUILD_TYPE=release

ENV ARROW_HOME=/usr/local \
    PARQUET_HOME=/usr/local

# Download and build apache-arrow
RUN mkdir /arrow \
    && wget -q https://github.com/apache/arrow/archive/apache-arrow-${ARROW_VERSION}.tar.gz -O /tmp/apache-arrow.tar.gz \
    && tar -xvf /tmp/apache-arrow.tar.gz -C /arrow --strip-components 1 \
    && mkdir -p /arrow/cpp/build \
    && cd /arrow/cpp/build \
    && cmake -DCMAKE_BUILD_TYPE=$ARROW_BUILD_TYPE \
             -DOPENSSL_ROOT_DIR=/usr/local/ssl \
             -DCMAKE_INSTALL_LIBDIR=lib \
             -DCMAKE_INSTALL_PREFIX=$ARROW_HOME \
             -DARROW_WITH_BZ2=ON \
             -DARROW_WITH_ZLIB=ON \
             -DARROW_WITH_ZSTD=ON \
             -DARROW_WITH_LZ4=ON \
             -DARROW_WITH_SNAPPY=ON \
             -DARROW_PARQUET=ON \
             -DARROW_PYTHON=ON \
             -DARROW_PLASMA=ON \
             -DARROW_BUILD_TESTS=OFF \
             .. \
    && make -j$(nproc) \
    && make install \
    && cd /arrow/python \
    && python setup.py build_ext --build-type=$ARROW_BUILD_TYPE --with-parquet \
    && python setup.py install \
    && rm -rf /arrow /tmp/apache-arrow.tar.gz

FROM rhub/r-minimal:latest
COPY --from=builder /usr/local /usr/local

RUN apk --no-cache add pkgconfig libbz2 libgcc libstdc++ zlib-dev

RUN ARROW_USE_PKG_CONFIG=true \
    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig \
    R_LD_LIBRARY_PATH="/usr/lib:/usr/local/lib:/usr/local/lib/R/lib" \
    ARROW_R_DEV=true \
    installr -d "arrow"