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
GAIA_ECOSYSTEM_DETAIL+="\n\t+--[ Third_party : <Common> ]"

###################################################################
# PERL
###

if [ "${GAIA_THIRD_PARTY_PERL_FOUND}" = true ]; then

	# internal
	GAIA_THIRD_PARTY_PERL_ROOT=$GAIA_THIRD_PARTY_HOME/perl-$GAIA_THIRD_PARTY_PERL_VERSION
	GAIA_THIRD_PARTY_PERL_BINARYDIR=$GAIA_THIRD_PARTY_PERL_ROOT/bin
	GAIA_THIRD_PARTY_PERL_LIBRARYDIR=$GAIA_THIRD_PARTY_PERL_ROOT/lib/$GAIA_THIRD_PARTY_PERL_VERSION:$GAIA_THIRD_PARTY_PERL_ROOT/lib/site_perl/$GAIA_THIRD_PARTY_PERL_VERSION

	# info
	GAIA_ECOSYSTEM_DETAIL+="\n\t|\t* perl v.$GAIA_THIRD_PARTY_PERL_VERSION"

	# env
	PERL5LIB=$GAIA_THIRD_PARTY_PERL_LIBRARYDIR
	PATH=$GAIA_THIRD_PARTY_PERL_BINARYDIR:$PATH
	LD_LIBRARY_PATH=$GAIA_THIRD_PARTY_PERL_LIBRARYDIR:$LD_LIBRARY_PATH

	# export
	export PERL5LIB

	# clean
	unset GAIA_THIRD_PARTY_PERL_ROOT
	unset GAIA_THIRD_PARTY_PERL_LIBRARYDIR
	unset GAIA_THIRD_PARTY_PERL_BINARYDIR

fi

###################################################################
# CMake/Ctest/CPack
###

if [ "${GAIA_THIRD_PARTY_CMAKE_FOUND}" = true ]; then

	# unload any previous cmake versions if DSI host
	if [ "${GAIA_FOUND_DSI_HOST}" = true ]; then

		module unload cmake

	fi

	# internal
	GAIA_THIRD_PARTY_CMAKE_ROOT=$GAIA_THIRD_PARTY_HOME/cmake-$GAIA_THIRD_PARTY_CMAKE_VERSION
	GAIA_THIRD_PARTY_CMAKE_BINARYDIR=$GAIA_THIRD_PARTY_CMAKE_ROOT/bin
	GAIA_THIRD_PARTY_CMAKE_MODULE_PATH=$GAIA_THIRD_PARTY_CMAKE_ROOT/share/cmake-$GAIA_THIRD_PARTY_CMAKE_MAJ_VER.$GAIA_THIRD_PARTY_CMAKE_MIN_VER/Modules

	# info
	GAIA_ECOSYSTEM_DETAIL+="\n\t|\t* cmake v.$GAIA_THIRD_PARTY_CMAKE_VERSION"

	# env
	CMAKE_MODULE_PATH=$GAIA_THIRD_PARTY_CMAKE_MODULE_PATH
	PATH=$GAIA_THIRD_PARTY_CMAKE_BINARYDIR:$PATH

	# export
	export CMAKE_MODULE_PATH

	# clean
	unset GAIA_THIRD_PARTY_CMAKE_ROOT
	unset GAIA_THIRD_PARTY_CMAKE_MODULE_PATH
	unset GAIA_THIRD_PARTY_CMAKE_BINARYDIR

fi

###################################################################
# Xerces-C++
###

if [ "${GAIA_THIRD_PARTY_XERCES_FOUND}" = true ]; then

	# internal
	GAIA_THIRD_PARTY_XERCES_ROOT=$GAIA_THIRD_PARTY_HOME/xerces-$GAIA_THIRD_PARTY_XERCES_VERSION
	GAIA_THIRD_PARTY_XERCES_BINARYDIR=$GAIA_THIRD_PARTY_XERCES_ROOT/bin
	GAIA_THIRD_PARTY_XERCES_LIBRARYDIR=$GAIA_THIRD_PARTY_XERCES_ROOT/lib
	GAIA_THIRD_PARTY_XERCES_INCLUDEDIR=$GAIA_THIRD_PARTY_XERCES_ROOT/include

	# info
	GAIA_ECOSYSTEM_DETAIL+="\n\t|\t* xerces-c++ v.$GAIA_THIRD_PARTY_XERCES_VERSION"

	# env
	CPATH=$GAIA_THIRD_PARTY_XERCES_INCLUDEDIR:$CPATH
	PATH=$GAIA_THIRD_PARTY_XERCES_BINARYDIR:$PATH
	LD_LIBRARY_PATH=$GAIA_THIRD_PARTY_XERCES_LIBRARYDIR:$LD_LIBRARY_PATH
	PKG_CONFIG_PATH=$GAIA_THIRD_PARTY_XERCES_LIBRARYDIR/pkgconfig:$PKG_CONFIG_PATH

	# clean
	unset GAIA_THIRD_PARTY_XERCES_ROOT
	unset GAIA_THIRD_PARTY_XERCES_LIBRARYDIR
	unset GAIA_THIRD_PARTY_XERCES_INCLUDEDIR
	unset GAIA_THIRD_PARTY_XERCES_BINARYDIR

fi

###################################################################
# Doxygen
###

if [ "${GAIA_THIRD_PARTY_DOXYGEN_FOUND}" = true ]; then

	# internal
	GAIA_THIRD_PARTY_DOXYGEN_ROOT=$GAIA_THIRD_PARTY_HOME/doxygen-$GAIA_THIRD_PARTY_DOXYGEN_VERSION
	GAIA_THIRD_PARTY_DOXYGEN_BINARYDIR=$GAIA_THIRD_PARTY_DOXYGEN_ROOT/bin

	# info
	GAIA_ECOSYSTEM_DETAIL+="\n\t|\t* doxygen v.$GAIA_THIRD_PARTY_DOXYGEN_VERSION"

	# env
	PATH=$GAIA_THIRD_PARTY_DOXYGEN_BINARYDIR:$PATH

	# clean
	unset GAIA_THIRD_PARTY_DOXYGEN_ROOT
	unset GAIA_THIRD_PARTY_DOXYGEN_BINARYDIR

fi

###################################################################
# Boost
###

if [ "${GAIA_THIRD_PARTY_BOOST_FOUND}" = true ]; then

	# internal
	GAIA_THIRD_PARTY_BOOST_ROOT=$GAIA_THIRD_PARTY_HOME/boost-$GAIA_THIRD_PARTY_BOOST_VERSION
	GAIA_THIRD_PARTY_BOOST_LIBRARYDIR=$GAIA_THIRD_PARTY_BOOST_ROOT/lib
	GAIA_THIRD_PARTY_BOOST_INCLUDEDIR=$GAIA_THIRD_PARTY_BOOST_ROOT/include

	# info
	GAIA_ECOSYSTEM_DETAIL+="\n\t|\t* boost v.$GAIA_THIRD_PARTY_BOOST_VERSION"

	# env
	CPATH=$GAIA_THIRD_PARTY_BOOST_INCLUDEDIR:$CPATH
	LD_LIBRARY_PATH=$GAIA_THIRD_PARTY_BOOST_LIBRARYDIR:$LD_LIBRARY_PATH
	BOOST_ROOT="$GAIA_THIRD_PARTY_BOOST_ROOT"

	# export
	export BOOST_ROOT

	# clean
	unset GAIA_THIRD_PARTY_BOOST_ROOT
	unset GAIA_THIRD_PARTY_BOOST_LIBRARYDIR
	unset GAIA_THIRD_PARTY_BOOST_INCLUDEDIR

fi

#== EOF
