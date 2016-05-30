#!/bin/bash

echo; echo "## BEGIN"; echo

echo; echo " - CentOS EPEL repo - "; echo

echo; echo " - Common dependencies - "; echo

# Script d'installation des dependances necessaires aux differents codes
yum install \
	glib2-devel.x86_64 \
	glibc-devel.x86_64 \
	freetype-devel.x86_64 \
	freeglut-devel.x86_64 \
	gmp-devel.x86_64 \
	libXmu-devel.x86_64 \
	libXi-devel.x86_64 \
	libjpeg-turbo-devel.x86_64 \
	libpng-devel.x86_64 \
	libtiff-devel.x86_64 \
	SDL-devel.x86_64 \
	rsh.x86_64 \
	pcre-devel.x86_64 \
	java-1.8.0-openjdk-devel.x86_64 \
	ncurses-devel.x86_64 \
	graphviz.x86_64 \
	gc.x86_64 \
	libXinerama-devel.x86 \
	libXcursor-devel.x86_64_64 \
	freeimage-3.10.0-19.el7.x86_64.rpm \
        freeimage-devel-3.10.0-19.el7.x86_64.rpm \
	python-devel.x86_64 \
	bzip2-devel.x86_64


yum install \
	/data/CentOS_7.x/rpms/guile-2.0.9-5.el7.x86_64.rpm \
	/data/CentOS_7.x/rpms/guile-devel-2.0.9-5.el7.x86_64.rpm \
	/data/CentOS_7.x/rpms/gc-devel-7.2d-7.el7.x86_64.rpm \
	/data/CentOS_7.x/rpms/libGLEWmx-1.10.0-5.el7.x86_64.rpm \
	/data/CentOS_7.x/rpms/lua-devel-5.1.4-14.el7.x86_64.rpm \
	/data/CentOS_7.x/rpms/tolua++-1.0.93-14.el7.x86_64.rpm \
	/data/CentOS_7.x/rpms/tolua++-devel-1.0.93-14.el7.x86_64.rpm \
	/data/CentOS_7.x/rpms/glew-devel-1.10.0-5.el7.x86_64.rpm \
	/data/CentOS_7.x/rpms/giflib-devel-4.1.6-9.el7.x86_64.rpm

echo; echo " - QT5 dependencies - "; echo

# Script d'installation des dependances necessaires a QT5
yum install \
	libxcb \
	libxcb-devel \
	libXrender \
	libXrender-devel \
	xcb-util-wm \
	xcb-util \
	xcb-util-image \
	xcb-util-keysyms \
	flex \
	bison \
	libicu-devel \
	libxslt-devel \
	pulseaudio-libs-devel.x86_64 \
	ruby

yum install \
	/data/CentOS_7.x/rpms/xcb-util-devel-0.4.0-2.el7.x86_64.rpm \
	/data/CentOS_7.x/rpms/xcb-util-wm-devel-0.4.1-5.el7.x86_64.rpm \
	/data/CentOS_7.x/rpms/xcb-util-image-devel-0.4.0-2.el7.x86_64.rpm \
	/data/CentOS_7.x/rpms/xcb-util-keysyms-devel-0.4.0-1.el7.x86_64.rpm \
	/data/CentOS_7.x/rpms/gperf-3.0.4-8.el7.x86_64.rpm \
	/data/CentOS_7.x/rpms/mtdev-devel-1.1.5-5.el7.x86_64

	
echo; echo "## END"; echo

