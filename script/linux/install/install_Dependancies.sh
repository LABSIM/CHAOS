#!/bin/bash

# montage du repo EPEL
yum install /data/CentOS_6.3/rpms/epel-release-6.8.noarch.rpm

# Script d'installation des dependances necessaires aux differents codes
yum install \
	glib2-devel.x86_64 \
	glibc-devel.x86_64 \
	glibc-devel.i686   \
	freetype-devel.x86_64 \
	freeglut-devel.x86_64 \
	gmp-devel.x86_64 \
	libXmu-devel.x86_64 \
	libXi-devel.x86_64 \
	libjpeg-devel.x86_64 \
	libpng-devel.x86_64 \
	libtiff-devel.x86_64 \
	guile-devel.x86_64 \
	SDL-devel.x86_64 \
	rsh.x86_64 \
	openal-soft-devel.x86_64 \
	pcre-devel.x86_64 \
	lua-devel.x86_64 \
	tolua++-devel.x86_64 \
	glew-devel.x86_64 \
	giflib-devel.x86_64 \
	libsndfile-devel.x86_64 \
	compat-glibc-headers-2.5-46.2.x86_64

