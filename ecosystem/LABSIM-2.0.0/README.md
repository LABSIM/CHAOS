
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
	   	- gcc *v.9.1.0*
	   	- gdb *v.8.2.1*
    - **Development (DEV)** -- ***required***
       - make *v.4.2.1*
       - perl *v.5.30.3*
       - c-ares *v.1.15.0*
       - openssl *v.1.1.1b*
       - git *v.2.21.0*
       - cmake *v.3.16.3*
       - xerces-c++ *v.3.2.2*
       - doxygen *v.1.8.14*
       - boost *v.1.72.0*
       - llvm *v.8.0.0*
    - **Simulation Frontend (SF)** -- *strongly recommended*
       - protobuf *v.3.7.1*
       - grpc *v.1.21.1*
    - **Simulation Backend (SB)** -- *strongly recommended*
       - libev *v.4.24.0*
       - nghttp2 *v.1.35.1*
       - opensplice *v.6.9.190403*
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
