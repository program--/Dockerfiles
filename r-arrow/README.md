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

This will copy over the following:

```
/usr/local
├── bin/
│   ├── R*
│   ├── Rscript*
│   ├── cygdb*
│   ├── cython*
│   ├── cythonize*
│   ├── f2py*
│   ├── f2py3*
│   ├── f2py3.8*
│   ├── idle -> idle3*
│   ├── idle3 -> idle3.8*
│   ├── idle3.8*
│   ├── installr*
│   ├── pip*
│   ├── pip3*
│   ├── pip3.8*
│   ├── plasma-store-server*
│   ├── plasma_store*
│   ├── py.test*
│   ├── pydoc -> pydoc3*
│   ├── pydoc3 -> pydoc3.8*
│   ├── pydoc3.8*
│   ├── pytest*
│   ├── python -> python3*
│   ├── python-config -> python3-config*
│   ├── python3 -> python3.8*
│   ├── python3-config -> python3.8-config*
│   ├── python3.8*
│   ├── python3.8-config*
│   ├── remotes.R
│   ├── wheel*
│   ├── 2to3 -> 2to3-3.8*
│   └── 2to3-3.8*
├── include/
│   ├── arrow/
│   ├── parquet/
│   ├── plasma/
│   └── python3.8/
├── lib/
│   ├── R/
│   ├── cmake/
│   ├── perl5/
│   ├── pkgconfig/
│   ├── python3.8/
│   ├── libarrow.a
│   ├── libarrow.so -> libarrow.so.500*
│   ├── libarrow.so.500 -> libarrow.so.500.0.0*
│   ├── libarrow.so.500.0.0*
│   ├── libarrow_bundled_dependencies.a
│   ├── libarrow_dataset.a
│   ├── libarrow_dataset.so -> libarrow_dataset.so.500*
│   ├── libarrow_dataset.so.500 -> libarrow_dataset.so.500.0.0*
│   ├── libarrow_dataset.so.500.0.0*
│   ├── libarrow_python.a
│   ├── libarrow_python.so -> libarrow_python.so.500*
│   ├── libarrow_python.so.500 -> libarrow_python.so.500.0.0*
│   ├── libarrow_python.so.500.0.0*
│   ├── libparquet.a
│   ├── libparquet.so -> libparquet.so.500*
│   ├── libparquet.so.500 -> libparquet.so.500.0.0*
│   ├── libparquet.so.500.0.0*
│   ├── libplasma.a
│   ├── libplasma.so -> libplasma.so.500*
│   ├── libplasma.so.500 -> libplasma.so.500.0.0*
│   ├── libplasma.so.500.0.0*
│   ├── libpython3.so*
│   ├── libpython3.8.so -> libpython3.8.so.1.0*
│   └── libpython3.8.so.1.0*
└── share/
    ├── ca-certificates/
    ├── doc/
    ├── man/
    └── perl5/
```

## Arrow Info
This build of `arrow` has the following capabilities:

```
Arrow package version: 5.0.0.2

Capabilities:
               
dataset    TRUE
parquet    TRUE
s3        FALSE
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

To reinstall with more optional capabilities enabled, see
  https://arrow.apache.org/docs/r/articles/install.html

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