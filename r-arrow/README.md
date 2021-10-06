# R-Minimal + Apache Arrow

This `Dockerfile` contains a compiled build of **Apache Arrow** on top of `rhub/r-minimal` running Alpine Linux 3.12.1.

## Copying Arrow Libraries in Multistage Build
> Note: the following instructions may not be 100% accurate as I'm not completely comfortable with build-time & run-time dependencies. As a result, there may be incorrect explanations or objectively unnecessary steps.

If you want to use these `arrow` libraries in another `Dockerfile`
you can copy them between images using a multistage build process.

Simply add

``` Dockerfile
COPY --from=jsinghm/r-arrow /usr/local /usr/local
```
within your custom `Dockerfile`.

## Arrow Info
This build of `arrow` has the following capabilities:

```
Arrow package version: 5.0.0.2

Capabilities:
               
dataset    TRUE
parquet    TRUE
s3         TRUE
utf8proc   TRUE
re2        TRUE
snappy     TRUE
gzip       TRUE
brotli    FALSE
zstd       TRUE
lz4        TRUE
lz4_frame  TRUE
lzo       FALSE
bz2        TRUE
jemalloc   TRUE
mimalloc  FALSE

Memory:
                  
Allocator jemalloc
Current    0 bytes
Max        0 bytes

Runtime:
                        
SIMD Level          avx2
Detected SIMD Level avx2

Build:
                           
C++ Library Version   5.0.0
C++ Compiler            GNU
C++ Compiler Version 10.3.1
```