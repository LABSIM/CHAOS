\#
\# GAIA : required LABSIM ground software ecosystem
\# Copyright (C) 2012-2016  Nawfel KINANI
\#
\# This program is free software: you can redistribute it and/or modify #
\# it under the terms of the GNU General Public License as published by#
\# the Free Software Foundation, either version 3 of the License, or#
\# (at your option) any later version.
\#
\# This program is distributed in the hope that it will be useful,
\# but WITHOUT ANY WARRANTY; without even the implied warranty of
\# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
\# GNU General Public License for more details.
\#
\# You should have received a copy of the GNU General Public License
\# along with this program; see the file COPYING.
\# If not, see <http://www.gnu.org/licenses/>.
\#

# LABSIM simulation software ecosystem

### Brief

> *name* : ***LABSIM***
> *version* : ***v.2.0.0***
> *author* : Nawfel KINANI
> *dept* : DTIS
> *unit* : ICNA

### Detail

- **Third party sofware** (a.k.a. *"feature"*)
    - **GNU** -- ***required***
       - libtool *v.2.4.6*
       - libunistring *v.0.9.10*
       - bdw-gc *v.8.0.0*
       - guile *v.2.2.4*
       - binutils *v.2.31.1*
       - gmp *v.6.1.2*
       - mpfr *v.4.0.1*
       - mpc *v.1.1.0*
       - autogen *v.5.18.16*
       - isl *v.0.20.0*
       - gcc *v.8.2.0*
       - gdb *v.8.2.0*
    - **Development (DEV)** -- ***required***
       - make *v.4.2.1*
       - perl *v.5.28.1*
       - cmake *v.3.13.1*
       - xerces-c++ *v.3.2.2*
       - doxygen *v.1.8.14*
       - boost *v.1.69.0*
       - llvm *v.7.0.0*
    - **Simulation Frontend (SF)** -- *strongly recommended*
       - c-ares *v.1.15.0*
       - openssl *v.1.1.1a*
       - protobuf *v.3.6.1*
       - grpc *v.1.17.0*
    - **Simulation Backend (SB)** -- *strongly recommended*
       - c-ares *v.1.15.0*
       - libev *v.4.24.0*
       - nghttp2 *v.1.35.1*
       - opensplice *v.6.9.181018*
    - **User Interface (UI)** -- *optional*
       - qt *v.5.12.0*
       - qt-creator *v.4.8.0*
    - **Image Generation (IG)** -- *optional*
       - gdal *v.2.3.2*
       - geos *v.3.7.1*
       - fftss *v.3.0.20071031*
       - openscenegraph *v.3.6.3*
       - silverlining *v.5.0.17* -- ***license***
       - triton *v.4.0.4* -- ***license***
    -  **Image Processing (IP)** -- *optional* -- *[ TODO ]* :)
       - opencv *v.3.1.0*
       - openpose *v.1.3.0*
