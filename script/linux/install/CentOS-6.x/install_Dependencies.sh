#!/bin/bash

echo; echo "## BEGIN"; echo

echo "########################################################"
echo "                       Dependencies                     "
echo "########################################################"

echo; echo " - Common dependencies - "; echo
sudo yum install \
	glib2-devel.x86_64 \
	glibc-devel.x86_64 \
	glibc-devel.i686   \
	freetype-devel.x86_64 \
	freeglut-devel.x86_64 \
	gmp-devel.x86_64 \
	libXmu-devel.x86_64 \
	libXi-devel.x86_64 \
	libjpeg-turbo-devel.x86_64 \
	libpng-devel.x86_64 \
	libtiff-devel.x86_64 \
	guile-devel.x86_64 \
	SDL-devel.x86_64 \
	rsh.x86_64 \
	pcre-devel.x86_64 \
	lua-devel.x86_64 \
	glew-devel.x86_64 \
	giflib-devel.x86_64 \
	libsndfile-devel.x86_64 \
	ncurses-devel.x86_64 \
	graphviz.x86_64

echo; echo " - User provided dependencies - "; echo
sudo yum install \
	/data/CentOS_6.x/rpms/lua-devel-5.1.4-4.1.el6.x86_64.rpm \
	/data/CentOS_6.x/rpms/tolua++-1.0.93-1.el6.x86_64.rpm \
	/data/CentOS_6.x/rpms/tolua++-devel-1.0.93-1.el6.x86_64.rpm

echo; echo " - QT5 dependencies - "; echo
sudo yum install \
	libxcb-devel.x86_64 \
	libXrender-devel.x86_64 \
	xcb-util-wm-devel.x86_64 \
	xcb-util-devel.x86_64 \
	xcb-util-image-devel.x86_64 \
	xcb-util-keysyms-devel.x86_64 \
	libicu-devel.x86_64 \
	libxslt-devel.x86_64 \
	flex.x86_64 \
	bison.x86_64 \
	gperf.x86_64 \
	ruby.x86_64
	
echo; echo "## END"; echo

