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
> *version* : ***v.1.0.0*** 
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
        - gcc *v.7.3.0*
        - gdb *v.8.1.0*
    - **Common** -- ***required***
        -  perl *v.5.26.1*
        -  cmake *v.3.11.0*
        -  xerces-c++ *v.3.2.1*
        -  doxygen *v.1.8.14*
        -  boost *v.1.67.0*
    - **User Interface (UI)** -- *optionnal*
        - qt *v.5.11.0*
        - qt-creator *v.4.6.0*
        - cegui *v.0.8.7* -- ***experimental***
        - ceed *v.0.8.0* -- ***experimental***
    - **Image Generation (IG)** -- *optionnal*
        -  osg *v.3.6.0*
        -  silverlining *v.5.0.15* -- ***license***
        -  fftss *v.3.0.0*
        -  triton *v.3.58.0* -- ***license*** 
    -  **Image Processing (IP)** -- *optionnal*
        - opencv *v.3.1.0*
        - openpose *v.1.3.0*
    - **Simulation (SIM)** -- *optionnal*
        - protobuf *v.3.5.0*
        - grpc *v.1.11.0*
        - gsoap *v.2.8.66*
        - ospl *v.6.7.180404*
    - **Virtual Reality (VR)** -- ***experimental***
        - hidapi *v.0.8.0*
        - jsoncpp *v.1.7.5*
        - vrpn *v.0.7.34*
        - osvr-libfunctionality *v.0.1.0*
        - osvr-core *v.0.6.0*
        - osvr-display *v.0.1.0*
        - osvr-tracker *v.0.1.0*
        - osvr-leapmotion *v.0.1.0*
