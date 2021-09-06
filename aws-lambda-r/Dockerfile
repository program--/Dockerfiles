FROM rhub/r-minimal:latest
COPY --from=public.ecr.aws/lambda/provided:al2 /lambda-entrypoint.sh /lambda-entrypoint.sh
COPY --from=public.ecr.aws/lambda/provided:al2 /usr/local/bin/aws-lambda-rie /usr/local/bin/aws-lambda-rie

ENV LAMBDA_TASK_ROOT=/var/task
ENV LAMBDA_RUNTIME_DIR=/var/runtime

RUN mkdir /var/runtime
RUN mkdir /var/task
WORKDIR /var/task
ENTRYPOINT ["/lambda-entrypoint.sh"]

# Install R and build tools
RUN installr -d -t curl-dev httr jsonlite logger

# Setup Lambda R Runtime
COPY runtime.R ${LAMBDA_TASK_ROOT}/
RUN chmod 755 -R ${LAMBDA_TASK_ROOT}/
RUN printf '#!/bin/sh\ncd $LAMBDA_TASK_ROOT\nRscript runtime.R' > /var/runtime/bootstrap \
    && chmod +x /var/runtime/bootstrap