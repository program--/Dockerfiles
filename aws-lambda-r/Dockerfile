FROM public.ecr.aws/lambda/provided:al2

ARG R_VERSION

# Install basic system dependencies
RUN yum -y install wget \
                   tar \
                   amazon-linux-extras

# Enable EPEL 7
RUN amazon-linux-extras enable epel

# Install R
RUN if [[ -z "$R_VERSION" ]] ; \
    then amazon-linux-extras install R4 ; \
    else wget https://cdn.rstudio.com/r/centos-7/pkgs/R-${R_VERSION}-1-1.x86_64.rpm \
         && yum -y install R-${R_VERSION}-1-1.x86_64.rpm \
         && rm R-${R_VERSION}-1-1.x86_64.rpm ; \
    fi

# Fix $PATH and $TAR
ENV PATH="${PATH}:/opt/R/${R_VERSION}/bin/" \
    TAR="/bin/tar"

RUN yum -y install openssl-devel \
                   libcurl-devel \
                   libxml2-devel

# Install `pak` and runtime.R dependencies
RUN Rscript -e "install.packages('pak', repos = 'https://cloud.r-project.org/')"
RUN Rscript -e "pak::pkg_install(c('httr', 'jsonlite', 'glue', 'logger'))"

# Setup Lambda R Runtime
COPY runtime.R ${LAMBDA_TASK_ROOT}/
RUN chmod 755 -R ${LAMBDA_TASK_ROOT}/
RUN printf '#!/bin/sh\ncd $LAMBDA_TASK_ROOT\nRscript runtime.R' > /var/runtime/bootstrap \
    && chmod +x /var/runtime/bootstrap