#!/bin/bash

#
# GAIA : required LABSIM ground software ecosystem
# Copyright (C) 2012-2016  Nawfel KINANI
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; see the file COPYING.
# If not, see <http://www.gnu.org/licenses/>.
#

echo; echo "## BEGIN"; echo

echo "########################################################"
echo "                       Dependencies                     "
echo "########################################################"

echo; echo " - Common dependencies - "; echo
sudo yum install \
	glib2-devel.x86_64 \
	glibc-devel.x86_64 \
	freetype-devel.x86_64 \
	freeglut-devel.x86_64 \
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
	graphviz.x86_64 \
	libudev-devel.x86_64 \
	libusb1-devel.x86_64 \
	lua-devel.x86_64 \
	tolua++.x86_64 \
	tolua++-devel.x86_64 \
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

