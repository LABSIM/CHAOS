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
GAIA_ECOSYSTEM_DETAIL+="\n\t+--[ Third_party : <GNU> ]"

###################################################################
# LibTool
###

if [ "${GAIA_THIRD_PARTY_LIBTOOL_FOUND}" = true ]; then

	# internal
	GAIA_THIRD_PARTY_LIBTOOL_ROOT=$GAIA_THIRD_PARTY_HOME/libtool-$GAIA_THIRD_PARTY_LIBTOOL_VERSION
	GAIA_THIRD_PARTY_LIBTOOL_BINARYDIR=$GAIA_THIRD_PARTY_LIBTOOL_ROOT/bin
	GAIA_THIRD_PARTY_LIBTOOL_LIBRARYDIR=$GAIA_THIRD_PARTY_LIBTOOL_ROOT/lib
	GAIA_THIRD_PARTY_LIBTOOL_INCLUDEDIR=$GAIA_THIRD_PARTY_LIBTOOL_ROOT/include

	# info
	GAIA_ECOSYSTEM_DETAIL+="\n\t|\t* libtool v.$GAIA_THIRD_PARTY_LIBTOOL_VERSION"

	# env
	CPATH=$GAIA_THIRD_PARTY_LIBTOOL_INCLUDEDIR:$CPATH
	PATH=$GAIA_THIRD_PARTY_LIBTOOL_BINARYDIR:$PATH
	LD_LIBRARY_PATH=$GAIA_THIRD_PARTY_LIBTOOL_LIBRARYDIR:$LD_LIBRARY_PATH

	# clean
	unset GAIA_THIRD_PARTY_LIBTOOL_ROOT
	unset GAIA_THIRD_PARTY_LIBTOOL_LIBRARYDIR
	unset GAIA_THIRD_PARTY_LIBTOOL_INCLUDEDIR
	unset GAIA_THIRD_PARTY_LIBTOOL_BINARYDIR

fi

###################################################################
# LibUnistring
###

if [ "${GAIA_THIRD_PARTY_LIBUNISTRING_FOUND}" = true ]; then

	# internal
	GAIA_THIRD_PARTY_LIBUNISTRING_ROOT=$GAIA_THIRD_PARTY_HOME/libunistring-$GAIA_THIRD_PARTY_LIBUNISTRING_VERSION
	GAIA_THIRD_PARTY_LIBUNISTRING_LIBRARYDIR=$GAIA_THIRD_PARTY_LIBUNISTRING_ROOT/lib
	GAIA_THIRD_PARTY_LIBUNISTRING_INCLUDEDIR=$GAIA_THIRD_PARTY_LIBUNISTRING_ROOT/include

	# info
	GAIA_ECOSYSTEM_DETAIL+="\n\t|\t* libunistring v.$GAIA_THIRD_PARTY_LIBUNISTRING_VERSION"

	# env
	CPATH=$GAIA_THIRD_PARTY_LIBUNISTRING_INCLUDEDIR:$CPATH
	LD_LIBRARY_PATH=$GAIA_THIRD_PARTY_LIBUNISTRING_LIBRARYDIR:$LD_LIBRARY_PATH

	# clean
	unset GAIA_THIRD_PARTY_LIBUNISTRING_ROOT
	unset GAIA_THIRD_PARTY_LIBUNISTRING_LIBRARYDIR
	unset GAIA_THIRD_PARTY_LIBUNISTRING_INCLUDEDIR

fi

###################################################################
# Boehm-Demers-Weiser conservative garbage collector
###

if [ "${GAIA_THIRD_PARTY_GC_FOUND}" = true ]; then

	# internal
	GAIA_THIRD_PARTY_GC_ROOT=$GAIA_THIRD_PARTY_HOME/gc-$GAIA_THIRD_PARTY_GC_VERSION
	GAIA_THIRD_PARTY_GC_LIBRARYDIR=$GAIA_THIRD_PARTY_GC_ROOT/lib
	GAIA_THIRD_PARTY_GC_INCLUDEDIR=$GAIA_THIRD_PARTY_GC_ROOT/include

	# info
	GAIA_ECOSYSTEM_DETAIL+="\n\t|\t* bdw-gc v.$GAIA_THIRD_PARTY_GC_VERSION"

	# env
	CPATH=$GAIA_THIRD_PARTY_GC_INCLUDEDIR:$CPATH
	LD_LIBRARY_PATH=$GAIA_THIRD_PARTY_GC_LIBRARYDIR:$LD_LIBRARY_PATH
	PKG_CONFIG_PATH=$GAIA_THIRD_PARTY_GC_LIBRARYDIR/pkgconfig:$PKG_CONFIG_PATH

	# clean
	unset GAIA_THIRD_PARTY_GC_ROOT
	unset GAIA_THIRD_PARTY_GC_LIBRARYDIR
	unset GAIA_THIRD_PARTY_GC_INCLUDEDIR

fi

###################################################################
# Guile
###

if [ "${GAIA_THIRD_PARTY_GUILE_FOUND}" = true ]; then

	# internal
	GAIA_THIRD_PARTY_GUILE_ROOT=$GAIA_THIRD_PARTY_HOME/guile-$GAIA_THIRD_PARTY_GUILE_VERSION
	GAIA_THIRD_PARTY_GUILE_BINARYDIR=$GAIA_THIRD_PARTY_GUILE_ROOT/bin
	GAIA_THIRD_PARTY_GUILE_LIBRARYDIR=$GAIA_THIRD_PARTY_GUILE_ROOT/lib
	GAIA_THIRD_PARTY_GUILE_INCLUDEDIR=$GAIA_THIRD_PARTY_GUILE_ROOT/include

	# info
	GAIA_ECOSYSTEM_DETAIL+="\n\t|\t* guile v.$GAIA_THIRD_PARTY_GUILE_VERSION"

	# env
	CPATH=$GAIA_THIRD_PARTY_GUILE_INCLUDEDIR:$CPATH
	PATH=$GAIA_THIRD_PARTY_GUILE_BINARYDIR:$PATH
	LD_LIBRARY_PATH=$GAIA_THIRD_PARTY_GUILE_LIBRARYDIR:$LD_LIBRARY_PATH
	PKG_CONFIG_PATH=$GAIA_THIRD_PARTY_GUILE_LIBRARYDIR/pkgconfig:$PKG_CONFIG_PATH

	# clean
	unset GAIA_THIRD_PARTY_GUILE_ROOT
	unset GAIA_THIRD_PARTY_GUILE_LIBRARYDIR
	unset GAIA_THIRD_PARTY_GUILE_INCLUDEDIR
	unset GAIA_THIRD_PARTY_GUILE_BINARYDIR

fi

###################################################################
# Binutils
###

if [ "${GAIA_THIRD_PARTY_BINUTILS_FOUND}" = true ]; then

	# internal
	GAIA_THIRD_PARTY_BINUTILS_ROOT=$GAIA_THIRD_PARTY_HOME/binutils-$GAIA_THIRD_PARTY_BINUTILS_VERSION
	GAIA_THIRD_PARTY_BINUTILS_BINARYDIR=$GAIA_THIRD_PARTY_BINUTILS_ROOT/bin
	GAIA_THIRD_PARTY_BINUTILS_LIBRARYDIR=$GAIA_THIRD_PARTY_BINUTILS_ROOT/lib
	GAIA_THIRD_PARTY_BINUTILS_INCLUDEDIR=$GAIA_THIRD_PARTY_BINUTILS_ROOT/include

	# info
	GAIA_ECOSYSTEM_DETAIL+="\n\t|\t* binutils v.$GAIA_THIRD_PARTY_BINUTILS_VERSION"

	# env
	CPATH=$GAIA_THIRD_PARTY_BINUTILS_INCLUDEDIR:$CPATH
	PATH=$GAIA_THIRD_PARTY_BINUTILS_BINARYDIR:$PATH
	LD_LIBRARY_PATH=$GAIA_THIRD_PARTY_BINUTILS_LIBRARYDIR:$LD_LIBRARY_PATH

	# clean
	unset GAIA_THIRD_PARTY_BINUTILS_ROOT
	unset GAIA_THIRD_PARTY_BINUTILS_LIBRARYDIR
	unset GAIA_THIRD_PARTY_BINUTILS_INCLUDEDIR
	unset GAIA_THIRD_PARTY_BINUTILS_BINARYDIR

fi

###################################################################
# GMP
###

if [ "${GAIA_THIRD_PARTY_GMP_FOUND}" = true ]; then

	# internal
	GAIA_THIRD_PARTY_GMP_ROOT=$GAIA_THIRD_PARTY_HOME/gmp-$GAIA_THIRD_PARTY_GMP_VERSION
	GAIA_THIRD_PARTY_GMP_LIBRARYDIR=$GAIA_THIRD_PARTY_GMP_ROOT/lib
	GAIA_THIRD_PARTY_GMP_INCLUDEDIR=$GAIA_THIRD_PARTY_GMP_ROOT/include

	# info
	GAIA_ECOSYSTEM_DETAIL+="\n\t|\t* gmp v.$GAIA_THIRD_PARTY_GMP_VERSION"

	# env
	CPATH=$GAIA_THIRD_PARTY_GMP_INCLUDEDIR:$CPATH
	LD_LIBRARY_PATH=$GAIA_THIRD_PARTY_GMP_LIBRARYDIR:$LD_LIBRARY_PATH

	# clean
	unset GAIA_THIRD_PARTY_GMP_ROOT
	unset GAIA_THIRD_PARTY_GMP_LIBRARYDIR
	unset GAIA_THIRD_PARTY_GMP_INCLUDEDIR

fi

###################################################################
# MPC
###

if [ "${GAIA_THIRD_PARTY_MPC_FOUND}" = true ]; then

	# internal
	GAIA_THIRD_PARTY_MPC_ROOT=$GAIA_THIRD_PARTY_HOME/mpc-$GAIA_THIRD_PARTY_MPC_VERSION
	GAIA_THIRD_PARTY_MPC_LIBRARYDIR=$GAIA_THIRD_PARTY_MPC_ROOT/lib
	GAIA_THIRD_PARTY_MPC_INCLUDEDIR=$GAIA_THIRD_PARTY_MPC_ROOT/include

	# info
	GAIA_ECOSYSTEM_DETAIL+="\n\t|\t* mpc v.$GAIA_THIRD_PARTY_MPC_VERSION"

	# env
	CPATH=$GAIA_THIRD_PARTY_MPC_INCLUDEDIR:$CPATH
	LD_LIBRARY_PATH=$GAIA_THIRD_PARTY_MPC_LIBRARYDIR:$LD_LIBRARY_PATH

	# clean
	unset GAIA_THIRD_PARTY_MPC_ROOT
	unset GAIA_THIRD_PARTY_MPC_LIBRARYDIR
	unset GAIA_THIRD_PARTY_MPC_INCLUDEDIR

fi

###################################################################
# MPFR
###

if [ "${GAIA_THIRD_PARTY_MPFR_FOUND}" = true ]; then

	# internal
	GAIA_THIRD_PARTY_MPFR_ROOT=$GAIA_THIRD_PARTY_HOME/mpfr-$GAIA_THIRD_PARTY_MPFR_VERSION
	GAIA_THIRD_PARTY_MPFR_LIBRARYDIR=$GAIA_THIRD_PARTY_MPFR_ROOT/lib
	GAIA_THIRD_PARTY_MPFR_INCLUDEDIR=$GAIA_THIRD_PARTY_MPFR_ROOT/include

	# info
	GAIA_ECOSYSTEM_DETAIL+="\n\t|\t* mpfr v.$GAIA_THIRD_PARTY_MPFR_VERSION"

	# env
	CPATH=$GAIA_THIRD_PARTY_MPFR_INCLUDEDIR:$CPATH
	LD_LIBRARY_PATH=$GAIA_THIRD_PARTY_MPFR_LIBRARYDIR:$LD_LIBRARY_PATH

	# clean
	unset GAIA_THIRD_PARTY_MPFR_ROOT
	unset GAIA_THIRD_PARTY_MPFR_LIBRARYDIR
	unset GAIA_THIRD_PARTY_MPFR_INCLUDEDIR

fi

###################################################################
# ISL
###

if [ "${GAIA_THIRD_PARTY_ISL_FOUND}" = true ]; then

	# internal
	GAIA_THIRD_PARTY_ISL_ROOT=$GAIA_THIRD_PARTY_HOME/isl-$GAIA_THIRD_PARTY_ISL_VERSION
	GAIA_THIRD_PARTY_ISL_LIBRARYDIR=$GAIA_THIRD_PARTY_ISL_ROOT/lib
	GAIA_THIRD_PARTY_ISL_INCLUDEDIR=$GAIA_THIRD_PARTY_ISL_ROOT/include

	# info
	GAIA_ECOSYSTEM_DETAIL+="\n\t|\t* isl v.$GAIA_THIRD_PARTY_ISL_VERSION"

	# env
	CPATH=$GAIA_THIRD_PARTY_ISL_INCLUDEDIR:$CPATH
	LD_LIBRARY_PATH=$GAIA_THIRD_PARTY_ISL_LIBRARYDIR:$LD_LIBRARY_PATH

	# clean
	unset GAIA_THIRD_PARTY_ISL_ROOT
	unset GAIA_THIRD_PARTY_ISL_LIBRARYDIR
	unset GAIA_THIRD_PARTY_ISL_INCLUDEDIR

fi

###################################################################
# AutoGen
###

if [ "${GAIA_THIRD_PARTY_AUTOGEN_FOUND}" = true ]; then

	# internal
	GAIA_THIRD_PARTY_AUTOGEN_ROOT=$GAIA_THIRD_PARTY_HOME/autogen-$GAIA_THIRD_PARTY_AUTOGEN_VERSION
	GAIA_THIRD_PARTY_AUTOGEN_BINARYDIR=$GAIA_THIRD_PARTY_AUTOGEN_ROOT/bin
	GAIA_THIRD_PARTY_AUTOGEN_LIBRARYDIR=$GAIA_THIRD_PARTY_AUTOGEN_ROOT/lib
	GAIA_THIRD_PARTY_AUTOGEN_INCLUDEDIR=$GAIA_THIRD_PARTY_AUTOGEN_ROOT/include

	# info
	GAIA_ECOSYSTEM_DETAIL+="\n\t|\t* autogen v.$GAIA_THIRD_PARTY_AUTOGEN_VERSION"

	# env
	CPATH=$GAIA_THIRD_PARTY_AUTOGEN_INCLUDEDIR:$CPATH
	PATH=$GAIA_THIRD_PARTY_AUTOGEN_BINARYDIR:$PATH
	LD_LIBRARY_PATH=$GAIA_THIRD_PARTY_AUTOGEN_LIBRARYDIR:$LD_LIBRARY_PATH

	# clean
	unset GAIA_THIRD_PARTY_AUTOGEN_ROOT
	unset GAIA_THIRD_PARTY_AUTOGEN_LIBRARYDIR
	unset GAIA_THIRD_PARTY_AUTOGEN_INCLUDEDIR
	unset GAIA_THIRD_PARTY_AUTOGEN_BINARYDIR

fi

###################################################################
# GCC
###

if [ "${GAIA_THIRD_PARTY_GCC_FOUND}" = true ]; then

	# unload any previous GCC/GDB versions if DSI host
	if [ "${GAIA_FOUND_DSI_HOST}" = true ]; then

		module unload gcc

	fi

	# internal
	GAIA_THIRD_PARTY_GCC_ROOT=$GAIA_THIRD_PARTY_HOME/gcc-$GAIA_THIRD_PARTY_GCC_VERSION
	GAIA_THIRD_PARTY_GCC_BINARYDIR=$GAIA_THIRD_PARTY_GCC_ROOT/bin
	GAIA_THIRD_PARTY_GCC_LIBRARYDIR=$GAIA_THIRD_PARTY_GCC_ROOT/lib
	GAIA_THIRD_PARTY_GCC_LIBRARY64DIR=$GAIA_THIRD_PARTY_GCC_ROOT/lib64
	GAIA_THIRD_PARTY_GCC_LIBRARYEXECDIR=$GAIA_THIRD_PARTY_GCC_ROOT/libexec/gcc/x86_64-unknown-linux-gnu/$GAIA_THIRD_PARTY_GCC_VERSION
	GAIA_THIRD_PARTY_GCC_INCLUDEDIR=$GAIA_THIRD_PARTY_GCC_ROOT/include

	# info
	GAIA_ECOSYSTEM_DETAIL+="\n\t|\t* gcc v.$GAIA_THIRD_PARTY_GCC_VERSION"

	# env
	CC=$GAIA_THIRD_PARTY_GCC_BINARYDIR/gcc
	CXX=$GAIA_THIRD_PARTY_GCC_BINARYDIR/g++
	CPATH=$GAIA_THIRD_PARTY_GCC_INCLUDEDIR:$CPATH
	PATH=$GAIA_THIRD_PARTY_GCC_BINARYDIR:$GAIA_THIRD_PARTY_GCC_LIBRARYEXECDIR:$PATH
	LD_LIBRARY_PATH=$GAIA_THIRD_PARTY_GCC_LIBRARYDIR:$GAIA_THIRD_PARTY_GCC_LIBRARY64DIR:$LD_LIBRARY_PATH

	# export
	export CC CXX

	# clean
	unset GAIA_THIRD_PARTY_GCC_ROOT
	unset GAIA_THIRD_PARTY_GCC_LIBRARYDIR
	unset GAIA_THIRD_PARTY_GCC_LIBRARY64DIR
	unset GAIA_THIRD_PARTY_GCC_LIBRARYEXECDIR
	unset GAIA_THIRD_PARTY_GCC_INCLUDEDIR
	unset GAIA_THIRD_PARTY_GCC_BINARYDIR

fi

###################################################################
# GDB
###

if [ "${GAIA_THIRD_PARTY_GDB_FOUND}" = true ]; then

	# unload any previous GCC/GDB versions if DSI host
	if [ "${GAIA_FOUND_DSI_HOST}" = true ]; then

		module unload gdb

	fi

	# internal
	GAIA_THIRD_PARTY_GDB_ROOT=$GAIA_THIRD_PARTY_HOME/gdb-$GAIA_THIRD_PARTY_GDB_VERSION
	GAIA_THIRD_PARTY_GDB_BINARYDIR=$GAIA_THIRD_PARTY_GDB_ROOT/bin
	GAIA_THIRD_PARTY_GDB_LIBRARYDIR=$GAIA_THIRD_PARTY_GDB_ROOT/lib
	GAIA_THIRD_PARTY_GDB_INCLUDEDIR=$GAIA_THIRD_PARTY_GDB_ROOT/include

	# info
	GAIA_ECOSYSTEM_DETAIL+="\n\t|\t* gdb v.$GAIA_THIRD_PARTY_GDB_VERSION"

	# env
	CPATH=$GAIA_THIRD_PARTY_GDB_INCLUDEDIR:$CPATH
	PATH=$GAIA_THIRD_PARTY_GDB_BINARYDIR:$PATH
	LD_LIBRARY_PATH=$GAIA_THIRD_PARTY_GDB_LIBRARYDIR:$LD_LIBRARY_PATH

	# clean
	unset GAIA_THIRD_PARTY_GDB_ROOT
	unset GAIA_THIRD_PARTY_GDB_LIBRARYDIR
	unset GAIA_THIRD_PARTY_GDB_INCLUDEDIR
	unset GAIA_THIRD_PARTY_GDB_BINARYDIR

fi

#== EOF
