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
GAIA_DISTRIBUTION_DETAIL+="\n\t+--[ Third_party : <Simulation Backend (SB)> ]"

###################################################################
# GSOAP
###

if [ "${GAIA_THIRD_PARTY_GSOAP_FOUND}" = true ]; then

	# internal
	GAIA_THIRD_PARTY_GSOAP_ROOT=$GAIA_THIRD_PARTY_HOME/gsoap-$GAIA_THIRD_PARTY_GSOAP_VERSION
	GAIA_THIRD_PARTY_GSOAP_LIBRARYDIR=$GAIA_THIRD_PARTY_GSOAP_ROOT/lib
	GAIA_THIRD_PARTY_GSOAP_INCLUDEDIR=$GAIA_THIRD_PARTY_GSOAP_ROOT/include
	GAIA_THIRD_PARTY_GSOAP_BINARYDIR=$GAIA_THIRD_PARTY_GSOAP_ROOT/bin

	# info
	GAIA_DISTRIBUTION_DETAIL+="\n\t|\t* gSOAP v.$GAIA_THIRD_PARTY_GSOAP_VERSION"

	# env
	CPATH=$GAIA_THIRD_PARTY_GSOAP_INCLUDEDIR:$CPATH
	PATH=$GAIA_THIRD_PARTY_GSOAP_BINARYDIR:$PATH
	LD_LIBRARY_PATH=$GAIA_THIRD_PARTY_GSOAP_LIBRARYDIR:$LD_LIBRARY_PATH
	PKG_CONFIG_PATH=$GAIA_THIRD_PARTY_GSOAP_LIBRARYDIR/pkgconfig:$PKG_CONFIG_PATH

	# clean
	unset GAIA_THIRD_PARTY_GSOAP_ROOT
	unset GAIA_THIRD_PARTY_GSOAP_LIBRARYDIR
	unset GAIA_THIRD_PARTY_GSOAP_INCLUDEDIR
	unset GAIA_THIRD_PARTY_GSOAP_BINARYDIR

fi

###################################################################
# OpenSplice
###

if [ "${GAIA_THIRD_PARTY_OPENSPLICE_FOUND}" = true ]; then

	# internal
	GAIA_THIRD_PARTY_OPENSPLICE_ROOT=$GAIA_THIRD_PARTY_HOME/opensplice-$GAIA_THIRD_PARTY_OPENSPLICE_VERSION

	# info
	GAIA_DISTRIBUTION_DETAIL+="\n\t|\t* opensplice v.$GAIA_THIRD_PARTY_OPENSPLICE_VERSION"

	# source release file --> automatically configure environment
	source "$GAIA_THIRD_PARTY_OPENSPLICE_ROOT/release.com"

	# clean
	unset GAIA_THIRD_PARTY_OPENSPLICE_ROOT

fi

#== EOF
