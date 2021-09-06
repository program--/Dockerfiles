# AWS Lambda R Runtime

> This `Dockerfile` and R code is a fork of https://github.com/mdneuzerling/r-on-lambda.
> David's blog post on this topic can be [viewed here](https://mdneuzerling.com/post/r-on-aws-lambda-with-containers/).

This `Dockerfile` implements a custom R runtime for
AWS Lambda containers as described [here](https://docs.aws.amazon.com/lambda/latest/dg/runtimes-custom.html).

[`rhub/r-minimal`](https://github.com/r-hub/r-minimal) is used as the base container for this container.

## Usage
To use your R functions with this container, simply create a new `Dockerfile` and use:
``` Dockerfile
FROM jsinghm/aws-lambda-r:latest
```
as the base container. Then, create an R file with the function(s) you want to call, i.e.

``` r
# myfunctions.R
r_lambda_call <- function(arg) {
    list("passed" = as.character(arg))
}
```

and `COPY` the R file into the `$LAMBDA_TASK_ROOT` in your container:

``` Dockerfile
# Dockerfile
COPY myfunctions.R ${LAMBDA_TASK_ROOT}/
```

Now just add a `CMD` line with the corresponding `file.function` syntax:
``` Dockerfile
# Dockerfile
CMD ["myfunctions.r_lambda_call"]
```
> Alternatively, this can be added in the Lambda console.

An example of the full custom `Dockerfile` is:
``` Dockerfile
FROM jsinghm/aws-lambda-r:latest

COPY myfunctions.R ${LAMBDA_TASK_ROOT}/

CMD ["myfunctions.r_lambda_call"]
```