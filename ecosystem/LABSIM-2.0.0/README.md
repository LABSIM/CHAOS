
# LABSIM simulation software ecosystem

## Brief

> *name* : ***LABSIM***
> *version* : ***v.2.0.0***
> *author* : Nawfel KINANI
> *dept* : DTIS
> *unit* : ICNA

## Valid distros

- [ubuntu-ext-dev](../../disto/ubuntu-ext-dev)

## Ecosystem Detail

**Third party sofware** (a.k.a. *"feature"*)

| Features | Libraries |
| :--: | :-- |
| **GNU** <br/> *-mandatory-* | [libtool](https://www.gnu.org/software/libtool/) *v.2.4.6* <br/>[libunistring](https://www.gnu.org/software/libunistring/) *v.0.9.10*<br/>[bdw-gc](https://www.hboehm.info/gc/) *v.8.0.4*<br/>[guile](https://www.gnu.org/software/guile/) *v.3.0.2*<br/>[binutils](https://www.gnu.org/software/binutils/) *v.2.34.0*<br/>[gmp](https://gmplib.org/) *v.6.2.0*<br/>[mpfr](https://www.mpfr.org/) *v.4.0.2*<br/>[mpc](http://www.multiprecision.org/mpc/) *v.1.1.0* <br/>[autogen](https://www.gnu.org/software/autogen/) *v.5.18.16*<br/>[isl](http://isl.gforge.inria.fr/) *v.0.22.1*<br/>[gcc](https://gcc.gnu.org/) *v.10.1.0*<br/>[gdb](https://www.gnu.org/software/gdb/) *v.9.2.0*<br/>[make](https://www.gnu.org/software/make/) *v.4.2.1* |
| **Development (DEV)** <br/> *-required-* | [perl](https://www.perl.org/) *v.5.30.3*<br/>[c-ares](https://c-ares.haxx.se/) *v.1.15.0*<br/>[openssl](https://www.openssl.org/) *v.1.1.1b*<br/>[git](https://git-scm.com/) *v.2.21.0*<br/>[cmake](https://cmake.org/) *v.3.17.3*<br/>[xerces-c++](http://xerces.apache.org/xerces-c/) *v.3.2.2*<br/>[doxygen](https://www.doxygen.nl/index.html) *v.1.8.14*<br/>[boost](https://www.boost.org/) *v.1.73.0* |
|**LLVM** <br/> *-optional-* | [llvm](https://llvm.org/) *v.10.0.0* |
|**Simulation Frontend (SF)** <br/> *-strongly recommended-* | [protobuf](https://developers.google.com/protocol-buffers) *v.3.12.3*<br/>[grpc](https://grpc.io/) *v.1.29.1* |
|**Simulation Backend (SB)** <br/> *-strongly recommended-* | [libev](http://software.schmorp.de/pkg/libev.html) *v.4.33.0*<br/>[nghttp2](https://nghttp2.org/) *v.1.35.1*<br/>[opensplice](https://www.adlinktech.com/en/vortex-opensplice-data-distribution-service) *v.6.9.190925* |
|**User Interface (UI)** <br/> *-optional-* | [qt](https://www.qt.io/) *v.5.12.0* <br/>[qt-creator](https://www.qt.io/product/development-tools) *v.4.8.0* |
|**Image Generation (IG)** <br/> *-optional-* | [gdal](https://gdal.org/) *v.2.3.2*<br/>[geos](https://trac.osgeo.org/geos) *v.3.7.1*<br/>[fftss](https://www.ssisc.org/fftss/index.html.en) *v.3.0.20071031*<br/>[openscenegraph](http://www.openscenegraph.org/) *v.3.6.3*<br/>[silverlining](https://sundog-soft.com/features/real-time-3d-clouds/) *v.5.0.17* -- ***license***<br/>[triton](https://sundog-soft.com/features/ocean-and-water-rendering-with-triton/) *v.4.0.4* -- ***license*** |
|**Image Processing (IP)** <br/> *-optional- [ TODO ]* :) | [opencv](https://opencv.org/) *v.3.1.0*<br/>[openpose](https://github.com/CMU-Perceptual-Computing-Lab/openpose) *v.1.3.0* |