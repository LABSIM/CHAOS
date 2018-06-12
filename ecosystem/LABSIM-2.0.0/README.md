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
        - binutils *v.2.30.0*
        - gmp *v.6.1.2*
        - mpfr *v.4.0.1*
        - mpc *v.1.1.0*
        - autogen *v.5.18.4*
        - isl *v.0.19.0*
        - gcc *v.8.1.0*
        - gdb *v.8.1.0*
    - **Common** -- ***required***
        -  perl *v.5.26.1*
        -  cmake *v.3.11.0*
        -  xerces-c++ *v.3.2.1*
        -  doxygen *v.1.8.14*
        -  boost *v.1.67.0*
    - **Simulation Frontend (SF)** -- *strongly recommended*
        - protobuf *v.3.5.0*
        - grpc *v.1.11.0*
    - **Simulation Backend (SB)** -- *strongly recommended*
        - nghttp2 *v.1.32.0*
        - gsoap *v.2.8.66*
        - opensplice *v.6.7.0*
    - **User Interface (UI)** -- *optional*
        - qt *v.5.10.1*
        - qt-creator *v.4.6.0*
    - **Image Generation (IG)** -- *optional*
    	- gdal *v.2.2.4*
    	- geos *v.3.6.2*
        - fftss *v.3.0.20071031*
        - openscenegraph *v.3.6.0*
        - silverlining *v.5.0.17* -- ***license***
        - triton *v.4.0.4* -- ***license*** 
    -  **Image Processing (IP)** -- *optional*
        - opencv *v.3.1.0*
        - openpose *v.1.3.0*
