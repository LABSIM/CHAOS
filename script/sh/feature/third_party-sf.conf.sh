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
GAIA_ECOSYSTEM_DETAIL+="\n\t+--[ Third_party : <Simulation Frontend (SF)> ]"

###################################################################
# PROTOBUF
###

if [ "${GAIA_THIRD_PARTY_PROTOBUF_FOUND}" = true ]; then

	# internal
	GAIA_THIRD_PARTY_PROTOBUF_ROOT=$GAIA_THIRD_PARTY_HOME/protobuf-$GAIA_THIRD_PARTY_PROTOBUF_VERSION
	GAIA_THIRD_PARTY_PROTOBUF_LIBRARYDIR=$GAIA_THIRD_PARTY_PROTOBUF_ROOT/lib
	GAIA_THIRD_PARTY_PROTOBUF_INCLUDEDIR=$GAIA_THIRD_PARTY_PROTOBUF_ROOT/include
	GAIA_THIRD_PARTY_PROTOBUF_BINARYDIR=$GAIA_THIRD_PARTY_PROTOBUF_ROOT/bin

	# info
	GAIA_ECOSYSTEM_DETAIL+="\n\t|\t* Google Protocol Buffer v.$GAIA_THIRD_PARTY_PROTOBUF_VERSION"

	# env
	CPATH=$GAIA_THIRD_PARTY_PROTOBUF_INCLUDEDIR:$CPATH
	PATH=$GAIA_THIRD_PARTY_PROTOBUF_BINARYDIR:$PATH
	LD_LIBRARY_PATH=$GAIA_THIRD_PARTY_PROTOBUF_LIBRARYDIR:$LD_LIBRARY_PATH
	PKG_CONFIG_PATH=$GAIA_THIRD_PARTY_PROTOBUF_LIBRARYDIR/pkgconfig:$PKG_CONFIG_PATH

	# clean
	unset GAIA_THIRD_PARTY_PROTOBUF_ROOT # keep it alive because of the cmake defaillance --> list(APPEND CMAKE_PREFIX_PATH "$ENV{GAIA_THIRD_PARTY_PROTOBUF_ROOT}")
	unset GAIA_THIRD_PARTY_PROTOBUF_LIBRARYDIR
	unset GAIA_THIRD_PARTY_PROTOBUF_INCLUDEDIR
	unset GAIA_THIRD_PARTY_PROTOBUF_BINARYDIR

fi

###################################################################
# GRPC
###

if [ "${GAIA_THIRD_PARTY_GRPC_FOUND}" = true ]; then

	# internal
	GAIA_THIRD_PARTY_GRPC_ROOT=$GAIA_THIRD_PARTY_HOME/grpc-$GAIA_THIRD_PARTY_GRPC_VERSION
	GAIA_THIRD_PARTY_GRPC_LIBRARYDIR=$GAIA_THIRD_PARTY_GRPC_ROOT/lib
	GAIA_THIRD_PARTY_GRPC_INCLUDEDIR=$GAIA_THIRD_PARTY_GRPC_ROOT/include
	GAIA_THIRD_PARTY_GRPC_BINARYDIR=$GAIA_THIRD_PARTY_GRPC_ROOT/bin

	# info
	GAIA_ECOSYSTEM_DETAIL+="\n\t|\t* Google gRPC v.$GAIA_THIRD_PARTY_GRPC_VERSION"

	# env
	CPATH=$GAIA_THIRD_PARTY_GRPC_INCLUDEDIR:$CPATH
	PATH=$GAIA_THIRD_PARTY_GRPC_BINARYDIR:$PATH
	LD_LIBRARY_PATH=$GAIA_THIRD_PARTY_GRPC_LIBRARYDIR:$LD_LIBRARY_PATH
	PKG_CONFIG_PATH=$GAIA_THIRD_PARTY_GRPC_LIBRARYDIR/pkgconfig:$PKG_CONFIG_PATH

	# clean
	unset GAIA_THIRD_PARTY_GRPC_ROOT # keep it alive because of the cmake defaillance --> list(APPEND CMAKE_PREFIX_PATH "$ENV{GAIA_THIRD_PARTY_GRPC_ROOT}")
	unset GAIA_THIRD_PARTY_GRPC_LIBRARYDIR
	unset GAIA_THIRD_PARTY_GRPC_INCLUDEDIR
	unset GAIA_THIRD_PARTY_GRPC_BINARYDIR

fi

#== EOF