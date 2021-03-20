FROM rocker/geospatial:4.0.2

RUN apt-get -y update && apt-get -y upgrade

# Setup renv
RUN Rscript -e 'install.packages("renv")'
RUN Rscript -e 'renv::consent(provided = TRUE)'

# Alternatively, you can install dependencies by using:
#> RUN install2.r package1 package2 ...

# Clone app from GitHub and set WORKDIR
WORKDIR ~
RUN git clone https://github.com/user/repository
WORKDIR repository

# Download packages (workaround for build memory issues) and run app
CMD  Rscript -e 'renv::restore()' && Rscript app.R