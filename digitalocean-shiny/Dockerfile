# Dockerfile for Shiny on DigitalOcean Apps
FROM rocker/shiny-verse

COPY . /srv/shiny-server

RUN install2.r \
    shinyjs \
    shiny.semantic

# Change port number here,
# if *not* using a reverse proxy,
# set this to 80 or 443
EXPOSE 3838