#!/bin/bash

if [ $# != 1 ]
then 
	echo "Veuillez spécifier le CD inseré en argument"
	exit
fi

# Script d'installation des dependances necessaires aux differents codes

if [ $1 == 1 ]
then

yum install \
	glib2-devel.x86_64 \
	glibc-devel.x86_64 \
	glibc-devel.y686   \
	giflib.x86_64 \
	freetype-devel.x86_64 \
	freeglut-devel.x86_64 \
	gmp-devel.x86_64 \
	libXmu-devel.x86_64 \
	libXi-devel.x86_64 \
	libjpeg-devel.x86_64 \
	libpng-devel.x86_64 \
	libtiff-devel.x86_64 \
	guile.x86_64 \
	SDL.x86_64 \
	SDL-devel.x86_64 \
	rsh.x86_64 \
	/data/CentOS_6.3/rpms/openal-soft-1.12.854-1.el6.x86_64.rpm \
	/data/CentOS_6.3/rpms/openal-soft-devel-1.12.854-1.el6.x86_64.rpm

else

yum install \
	guile-devel.x86_64 \
	giflib-devel.x86_64 \
	libsndfile-devel.x86_64

fi

