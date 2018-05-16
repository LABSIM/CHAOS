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

# detail
GAIA_DISTRIBUTION_DETAIL+="\n\t+--[ Third_party : <Image Generation (IG)> ]"

###################################################################
# GDAL
###

if [ "${GAIA_THIRD_PARTY_GDAL_FOUND}" = true ]; then

	# internal
	GAIA_THIRD_PARTY_GDAL_ROOT=$GAIA_THIRD_PARTY_HOME/gdal-$GAIA_THIRD_PARTY_GDAL_VERSION
	GAIA_THIRD_PARTY_GDAL_INCLUDEDIR=$GAIA_THIRD_PARTY_GDAL_ROOT/include
	GAIA_THIRD_PARTY_GDAL_LIBRARYDIR=$GAIA_THIRD_PARTY_GDAL_ROOT/lib
	GAIA_THIRD_PARTY_GDAL_BINARYDIR=$GAIA_THIRD_PARTY_GDAL_ROOT/bin

	# info
	GAIA_DISTRIBUTION_DETAIL+="\n\t|\t* GDAL v.$GAIA_THIRD_PARTY_GDAL_VERSION"

	# env
	CPATH=$GAIA_THIRD_PARTY_GDAL_INCLUDEDIR:$CPATH
	LD_LIBRARY_PATH=$GAIA_THIRD_PARTY_GDAL_LIBRARYDIR:$LD_LIBRARY_PATH
	PATH=$GAIA_THIRD_PARTY_GDAL_BINARYDIR:$PATH
	PKG_CONFIG_PATH=$GAIA_THIRD_PARTY_GSOAP_LIBRARYDIR/pkgconfig:$PKG_CONFIG_PATH
	GDAL_DATA=$GAIA_THIRD_PARTY_GDAL_ROOT/share/gdal

	# export
	export GDAL_DATA

	# clean
	unset GAIA_THIRD_PARTY_GDAL_ROOT
	unset GAIA_THIRD_PARTY_GDAL_INCLUDEDIR
	unset GAIA_THIRD_PARTY_GDAL_LIBRARYDIR
	unset GAIA_THIRD_PARTY_GDAL_BINARYDIR

fi

###################################################################
# GEOS
###

if [ "${GAIA_THIRD_PARTY_GEOS_FOUND}" = true ]; then

	# internal
	GAIA_THIRD_PARTY_GEOS_ROOT=$GAIA_THIRD_PARTY_HOME/geos-$GAIA_THIRD_PARTY_GEOS_VERSION
	GAIA_THIRD_PARTY_GEOS_INCLUDEDIR=$GAIA_THIRD_PARTY_GEOS_ROOT/include
	GAIA_THIRD_PARTY_GEOS_LIBRARYDIR=$GAIA_THIRD_PARTY_GEOS_ROOT/lib
	GAIA_THIRD_PARTY_GEOS_BINARYDIR=$GAIA_THIRD_PARTY_GEOS_ROOT/bin

	# info
	GAIA_DISTRIBUTION_DETAIL+="\n\t|\t* GEOS v.$GAIA_THIRD_PARTY_GDAL_VERSION"

	# env
	CPATH=$GAIA_THIRD_PARTY_GEOS_INCLUDEDIR:$CPATH
	LD_LIBRARY_PATH=$GAIA_THIRD_PARTY_GEOS_LIBRARYDIR:$LD_LIBRARY_PATH
	PATH=$GAIA_THIRD_PARTY_GEOS_BINARYDIR:$PATH

	# clean
	unset GAIA_THIRD_PARTY_GEOS_ROOT
	unset GAIA_THIRD_PARTY_GEOS_INCLUDEDIR
	unset GAIA_THIRD_PARTY_GEOS_LIBRARYDIR
	unset GAIA_THIRD_PARTY_GEOS_BINARYDIR

fi

###################################################################
# FFTSS
###

if [ "${GAIA_THIRD_PARTY_FFTSS_FOUND}" = true ]; then

	# internal
	GAIA_THIRD_PARTY_FFTSS_ROOT=$GAIA_THIRD_PARTY_HOME/fftss-$GAIA_THIRD_PARTY_FFTSS_VERSION
	GAIA_THIRD_PARTY_FFTSS_BINARYDIR=$GAIA_THIRD_PARTY_FFTSS_ROOT/bin
	GAIA_THIRD_PARTY_FFTSS_LIBRARYDIR=$GAIA_THIRD_PARTY_FFTSS_ROOT/lib
	GAIA_THIRD_PARTY_FFTSS_INCLUDEDIR=$GAIA_THIRD_PARTY_FFTSS_ROOT/include

	# info
	GAIA_DISTRIBUTION_DETAIL+="\n\t|\t* FFTSS v.$GAIA_THIRD_PARTY_FFTSS_VERSION"

	# env
	CPATH=$GAIA_THIRD_PARTY_FFTSS_INCLUDEDIR:$CPATH
	PATH=$GAIA_THIRD_PARTY_FFTSS_BINARYDIR:$PATH
	LD_LIBRARY_PATH=$GAIA_THIRD_PARTY_FFTSS_LIBRARYDIR:$LD_LIBRARY_PATH

	# clean
	unset GAIA_THIRD_PARTY_FFTSS_ROOT
	unset GAIA_THIRD_PARTY_FFTSS_LIBRARYDIR
	unset GAIA_THIRD_PARTY_FFTSS_INCLUDEDIR
	unset GAIA_THIRD_PARTY_FFTSS_BINARYDIR

fi

###################################################################
# OpenSceneGraph
###

if [ "${GAIA_THIRD_PARTY_OPENSCENEGRAPH_FOUND}" = true ]; then

	# internal
	GAIA_THIRD_PARTY_OPENSCENEGRAPH_ROOT=$GAIA_THIRD_PARTY_HOME/openscenegraph-$GAIA_THIRD_PARTY_OPENSCENEGRAPH_VERSION
	GAIA_THIRD_PARTY_OPENSCENEGRAPH_INCLUDEDIR=$GAIA_THIRD_PARTY_OPENSCENEGRAPH_ROOT/include
	GAIA_THIRD_PARTY_OPENSCENEGRAPH_LIBRARYDIR=$GAIA_THIRD_PARTY_OPENSCENEGRAPH_ROOT/lib64
	GAIA_THIRD_PARTY_OPENSCENEGRAPH_BINARYDIR=$GAIA_THIRD_PARTY_OPENSCENEGRAPH_ROOT/bin

	# info
	GAIA_DISTRIBUTION_DETAIL+="\n\t|\t* OpenSceneGraph v.$GAIA_THIRD_PARTY_OPENSCENEGRAPH_VERSION"

	# env
	#OSG_BDT=${BDD_HOME}/Bdt/
	#for path in $(find -L ${OSG_BDT} -maxdepth 1 -type d ! -name Bdt); do
	#	OSG_BDT=$OSG_BDT:$path
	#done

	#OSG_TEXTURE=${BDD_HOME}/Texture/
	#for path in $(find -L ${OSG_TEXTURE} -type d ! -name Texture); do
	#	OSG_TEXTURE=$OSG_TEXTURE:$path
	#done

	#OSG_DYNAMIC=${BDD_HOME}/Dynamic/
	#for path in $(find -L ${OSG_DYNAMIC} -type d ! -name Dynamic); do
	#	OSG_DYNAMIC=$OSG_DYNAMIC:$path
	#done

	#OSG_STATIC=${BDD_HOME}/Static/
	#for path in $(find -L ${OSG_STATIC} -type d ! -name Static); do
	#	OSG_STATIC=$OSG_STATIC:$path
	#done

	#OSG_FILE_PATH=$OSG_BDT:$OSG_TEXTURE:$OSG_DYNAMIC:$OSG_STATIC:$BDD_HOME/INSTRUMENT:$BDD_HOME/IMAGES_PA
	OSG_DIR=$GAIA_THIRD_PARTY_OPENSCENEGRAPH_ROOT
	OSG_NOTIFY_LEVEL=NOTICE
	OSG_OPTIMIZER="DEFAULT ~MAKE_FAST_GEOMETRY"
	CPATH=$GAIA_THIRD_PARTY_OPENSCENEGRAPH_INCLUDEDIR:$CPATH
	PATH=$GAIA_THIRD_PARTY_OPENSCENEGRAPH_BINARYDIR:$PATH
	LD_LIBRARY_PATH=$GAIA_THIRD_PARTY_OPENSCENEGRAPH_LIBRARYDIR:$LD_LIBRARY_PATH

	# export
	export OSG_DIR OSG_NOTIFY_LEVEL OSG_OPTIMIZER

	# clean
	unset GAIA_THIRD_PARTY_OPENSCENEGRAPH_ROOT
	unset GAIA_THIRD_PARTY_OPENSCENEGRAPH_LIBRARYDIR
	unset GAIA_THIRD_PARTY_OPENSCENEGRAPH_INCLUDEDIR
	unset GAIA_THIRD_PARTY_OPENSCENEGRAPH_BINARYDIR

fi

###################################################################
# SilverLining
###

if [ "${GAIA_THIRD_PARTY_SILVERLINING_FOUND}" = true ]; then

	# internal
	GAIA_THIRD_PARTY_SILVERLINING_ROOT=$GAIA_THIRD_PARTY_HOME/silverlining-$GAIA_THIRD_PARTY_SILVERLINING_VERSION
	GAIA_THIRD_PARTY_SILVERLINING_INCLUDEDIR=$GAIA_THIRD_PARTY_SILVERLINING_ROOT/Public\ Headers
	GAIA_THIRD_PARTY_SILVERLINING_LIBRARYDIR=$GAIA_THIRD_PARTY_SILVERLINING_ROOT/lib/linux

	# info
	GAIA_DISTRIBUTION_DETAIL+="\n\t|\t* Silverlining v.$GAIA_THIRD_PARTY_SILVERLINING_VERSION"

	# env
	SILVERLINING_DIR=$GAIA_THIRD_PARTY_SILVERLINING_ROOT
	SILVERLINING_PATH=$GAIA_THIRD_PARTY_SILVERLINING_ROOT/Resources
	CPATH=$GAIA_THIRD_PARTY_SILVERLINING_INCLUDEDIR:$CPATH
	LD_LIBRARY_PATH=$GAIA_THIRD_PARTY_SILVERLINING_LIBRARYDIR:$LD_LIBRARY_PATH

	# export
	export SILVERLINING_DIR SILVERLINING_PATH

	# clean
	unset GAIA_THIRD_PARTY_SILVERLINING_ROOT
	unset GAIA_THIRD_PARTY_SILVERLINING_LIBRARYDIR
	unset GAIA_THIRD_PARTY_SILVERLINING_INCLUDEDIR

fi

###################################################################
# Triton
###

if [ "${GAIA_THIRD_PARTY_TRITON_FOUND}" = true ]; then

	# internal
	GAIA_THIRD_PARTY_TRITON_ROOT=$GAIA_THIRD_PARTY_HOME/triton-$GAIA_TRITON_VERSION
	GAIA_THIRD_PARTY_TRITON_INCLUDEDIR=$GAIA_THIRD_PARTY_TRITON_ROOT/Public\ Headers
	GAIA_THIRD_PARTY_TRITON_LIBRARYDIR=$GAIA_THIRD_PARTY_TRITON_ROOT/lib/Linux/x64

	# info
	GAIA_DISTRIBUTION_DETAIL+="\n\t|\t* Triton v.$GAIA_THIRD_PARTY_TRITON_VERSION"

	# env
	TRITON_DIR=$GAIA_THIRD_PARTY_TRITON_ROOT
	TRITON_PATH=$GAIA_THIRD_PARTY_TRITON_ROOT/Resources
	CPATH=$GAIA_THIRD_PARTY_TRITON_INCLUDEDIR:$CPATH
	LD_LIBRARY_PATH=$GAIA_THIRD_PARTY_TRITON_LIBRARYDIR:$LD_LIBRARY_PATH

	# export
	export TRITON_DIR TRITON_PATH

	# clean
	unset GAIA_THIRD_PARTY_TRITON_ROOT
	unset GAIA_THIRD_PARTY_TRITON_LIBRARYDIR
	unset GAIA_THIRD_PARTY_TRITON_INCLUDEDIR

fi

###################################################################
# osgEARTH
###

if [ "${GAIA_THIRD_PARTY_OSGEARTH_FOUND}" = true ]; then

	# internal
	GAIA_THIRD_PARTY_OSGEARTH_ROOT=$GAIA_THIRD_PARTY_HOME/osgearth-$GAIA_THIRD_PARTY_OSGEARTH_VERSION
	GAIA_THIRD_PARTY_OSGEARTH_INCLUDEDIR=$GAIA_THIRD_PARTY_OSGEARTH_ROOT/include
	GAIA_THIRD_PARTY_OSGEARTH_LIBRARYDIR=$GAIA_THIRD_PARTY_OSGEARTH_ROOT/lib
	GAIA_THIRD_PARTY_OSGEARTH_BINARYDIR=$GAIA_THIRD_PARTY_OSGEARTH_ROOT/bin

	# info
	GAIA_DISTRIBUTION_DETAIL+="\n\t|\t* osgEarth v.$GAIA_THIRD_PARTY_OSGEARTH_VERSION"

	# env
	CPATH=$GAIA_THIRD_PARTY_OSGEARTH_INCLUDEDIR:$CPATH
	LD_LIBRARY_PATH=$GAIA_THIRD_PARTY_OSGEARTH_LIBRARYDIR:$LD_LIBRARY_PATH
	PATH=$GAIA_THIRD_PARTY_OSGEARTH_BINARYDIR:$PATH

	# clean
	unset GAIA_THIRD_PARTY_OSGEARTH_ROOT
	unset GAIA_THIRD_PARTY_OSGEARTH_INCLUDEDIR
	unset GAIA_THIRD_PARTY_OSGEARTH_LIBRARYDIR
	unset GAIA_THIRD_PARTY_OSGEARTH_BINARYDIR

fi

#== EOF
