FROM jsinghm/aws-lambda-rspatial:latest

# PDAL Dependencies for GRASS
COPY --from=mundialis/docker-pdal:2.1.0 /usr/bin/pdal* /usr/bin/
COPY --from=mundialis/docker-pdal:2.1.0 /usr/lib/libpdal* /usr/lib/
COPY --from=mundialis/docker-pdal:2.1.0 /usr/lib/pkgconfig/pdal.pc /usr/lib/pkgconfig/pdal.pc
COPY --from=mundialis/docker-pdal:2.1.0 /usr/include/pdal /usr/include/pdal
COPY --from=mundialis/docker-pdal:2.1.0 /usr/local/lib/liblaszip* /usr/local/lib/
COPY --from=mundialis/docker-pdal:2.1.0 /usr/local/include/laszip /usr/local/include/laszip

# Get GRASS GIS
COPY --from=mundialis/grass-py3-pdal:stable-alpine /usr/local/bin/grass /usr/local/bin/grass
COPY --from=mundialis/grass-py3-pdal:stable-alpine /usr/local/grass* /usr/local/grass/
RUN ln -s /usr/local/bin/grass /usr/local/bin/grass78

# Install Python 3.*
RUN apk add --no-cache python3 py3-pip && ln -sf python3 /usr/bin/python

# Install rgrass7
RUN installr -d -t libxml2-dev rgrass7