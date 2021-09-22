# AWS Lambda R Runtime with Spatial Libraries

This `Dockerfile` builds a container running a custom AWS Lambda Runtime for R on Alpine Linux that also includes the spatial libraries for GEOS, PROJ, and GDAL, and comes pre-installed with the R packages: `sf`, `RNetCDF`, `raster`, and `terra`. It uses [jsinghm/aws-lambda-r](https://github.com/program--/Dockerfiles/tree/master/aws-lambda-r) as the base container.

# Usage
[See the README here](https://github.com/program--/Dockerfiles/blob/master/aws-lambda-r/README.md).