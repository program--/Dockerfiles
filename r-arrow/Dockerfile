# ----------------------------------------------------
# Build Arrow
# ----------------------------------------------------
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
        zlib-dev \
        curl \
        curl-dev \
        openssl-dev \
        util-linux-dev \
        git

RUN pip install --no-cache-dir six pytest numpy cython
RUN pip install --no-cache-dir pandas

ARG ARROW_VERSION=6.0.1
ARG ARROW_BUILD_TYPE=release

ENV ARROW_HOME=/usr/local \
    PARQUET_HOME=/usr/local

RUN apk add --no-cache gflags-dev rapidjson-dev re2-dev zstd-dev \
                       lz4-libs snappy-dev clang clang-extra-tools \
                       utf8proc-dev libexecinfo

# Download and build apache-arrow
RUN mkdir /arrow \
    && wget -q https://github.com/apache/arrow/archive/apache-arrow-${ARROW_VERSION}.tar.gz -O /tmp/apache-arrow.tar.gz \
    && tar -xf /tmp/apache-arrow.tar.gz -C /arrow --strip-components 1 \
    && mkdir -p /arrow/cpp/build \
    && cd /arrow/cpp/build \
    && cmake -DCMAKE_BUILD_TYPE=$ARROW_BUILD_TYPE \
             -DOPENSSL_ROOT_DIR=/usr/local/ssl \
             -DCMAKE_PREFIX_PATH=/usr/local \
             -DCMAKE_INSTALL_LIBDIR=lib \
             -DCMAKE_INSTALL_PREFIX=$ARROW_HOME \
             -DARROW_S3=ON \
             -DARROW_WITH_BZ2=ON \
             -DARROW_WITH_ZLIB=ON \
             -DARROW_WITH_ZSTD=ON \
             -DARROW_WITH_LZ4=ON \
             -DARROW_WITH_SNAPPY=ON \
             -DARROW_PARQUET=ON \
             -DARROW_PYTHON=ON \
             -DARROW_PLASMA=ON \
             -DARROW_BUILD_TESTS=OFF \
             -DARROW_DEPENDENCY_SOURCE=AUTO \
             .. \
    && make -j $(nproc) \
    && make install \
    && cd /arrow/python \
    && python setup.py build_ext --build-type=$ARROW_BUILD_TYPE --with-parquet \
    && python setup.py install \
    && rm -rf /arrow /tmp/apache-arrow.tar.gz

# ----------------------------------------------------
# Final build
# ----------------------------------------------------

FROM rhub/r-minimal:latest
COPY --from=builder /usr/local /usr/local

RUN apk update \
    && apk upgrade \
    && apk --no-cache add pkgconfig libbz2 libgcc libstdc++ zlib-dev \
                          gflags-dev rapidjson-dev zstd-dev \
                          lz4-libs snappy-dev utf8proc-dev

RUN apk add --no-cache git make gcc g++ musl-dev \
    && git clone https://code.googlesource.com/re2 \
    && cd re2 \
    && make -j $(nproc) \
    && make test \
    && make install \
    && make testinstall \
    && cd .. \
    && rm -r re2 \
    && apk del git gcc g++ musl-dev

RUN ARROW_USE_PKG_CONFIG=true \
    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig \
    LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/usr/lib:/usr/local/lib:/usr/local/lib/R/lib:/usr/local/lib64" \
    R_LD_LIBRARY_PATH="${R_LD_LIBRARY_PATH}:/usr/lib:/usr/local/lib:/usr/local/lib/R/lib:/usr/local/lib64" \
    ARROW_R_DEV=true \
    installr -d "arrow"
