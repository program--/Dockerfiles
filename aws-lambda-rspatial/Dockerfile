FROM jsinghm/aws-lambda-r:latest

ENV GEOS_VERSION="3.7.3"
ENV PROJ_VERSION="6.1.1"
ENV GDAL_VERSION="3.2.1"

# Install Spatial Libraries
RUN yum -y update && \
    yum -y install cpp \
                   cmake3 \
                   make \
                   automake \
                   gcc \
                   gcc-c++ \
                   sqlite \
                   sqlite-devel \
                   libtiff \
                   libtiff-devel \
                   curl \
                   libcurl-devel \
                   bzip2 \
                   python3 \
                   python3-devel \
                   udunits2-devel

## Install GEOS
COPY install_geos.sh /tmp/
RUN chmod +x /tmp/install_geos.sh
RUN /tmp/install_geos.sh || exit 1

# Install PROJ
COPY install_proj.sh /tmp/
RUN chmod +x /tmp/install_proj.sh
RUN /tmp/install_proj.sh || exit 1

# Install GDAL
COPY install_gdal.sh /tmp/
RUN chmod +x /tmp/install_gdal.sh
RUN /tmp/install_gdal.sh || exit 1

# Fix symlinks
RUN ln -s /usr/local/lib/libgdal.so /usr/lib/libgdal.so.28 \
    && ln -s /usr/local/lib/libproj.so /usr/lib/libproj.so.15 \
    && ln -s /usr/local/lib/libgeos_c.so /usr/lib/libgeos_c.so.1 \
    && /sbin/ldconfig

# Install udunits2-devel
RUN wget https://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/u/udunits2-2.2.20-2.el7.x86_64.rpm \
    && wget https://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/u/udunits2-devel-2.2.20-2.el7.x86_64.rpm \
    && yum install -y udunits2-2.2.20-2.el7.x86_64.rpm udunits2-devel-2.2.20-2.el7.x86_64.rpm \
    && rm udunits2-2.2.20-2.el7.x86_64.rpm \
    && rm udunits2-devel-2.2.20-2.el7.x86_64.rpm

# Install `sf`
RUN Rscript -e "pak::pkg_install('sf')"