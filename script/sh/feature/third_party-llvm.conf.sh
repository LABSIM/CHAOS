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
GAIA_ECOSYSTEM_DETAIL+="\n\t+--[ Third_party : <LLVM> ]"

###################################################################
# LLVM
###

if [ "${GAIA_THIRD_PARTY_LLVM_FOUND}" = true ]; then

	# internal
	GAIA_THIRD_PARTY_LLVM_ROOT=$GAIA_THIRD_PARTY_HOME/llvm-$GAIA_THIRD_PARTY_LLVM_VERSION
	GAIA_THIRD_PARTY_LLVM_INCLUDEDIR=$GAIA_THIRD_PARTY_LLVM_ROOT/include
	GAIA_THIRD_PARTY_LLVM_LIBRARYDIR=$GAIA_THIRD_PARTY_LLVM_ROOT/lib
	GAIA_THIRD_PARTY_LLVM_BINARYDIR=$GAIA_THIRD_PARTY_LLVM_ROOT/bin

	# info
	GAIA_ECOSYSTEM_DETAIL+="\n\t|\t* LLVM project (Clang) v.$GAIA_THIRD_PARTY_LLVM_VERSION"

	# env
	LLVM_INSTALL_DIR=$GAIA_THIRD_PARTY_LLVM_ROOT
	CPATH=$GAIA_THIRD_PARTY_LLVM_INCLUDEDIR:$CPATH
	PATH=$GAIA_THIRD_PARTY_LLVM_BINARYDIR:$PATH
	LD_LIBRARY_PATH=$GAIA_THIRD_PARTY_LLVM_LIBRARYDIR:$LD_LIBRARY_PATH

	# export
	export LLVM_INSTALL_DIR

	# clean
	unset GAIA_THIRD_PARTY_LLVM_ROOT
	unset GAIA_THIRD_PARTY_LLVM_LIBRARYDIR
	unset GAIA_THIRD_PARTY_LLVM_INCLUDEDIR
	unset GAIA_THIRD_PARTY_LLVM_BINARYDIR

fi

#== EOF