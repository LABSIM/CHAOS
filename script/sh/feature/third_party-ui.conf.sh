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
GAIA_ECOSYSTEM_DETAIL+="\n\t+--[ Third_party : <User Interface (UI)> ]"

###################################################################
# QT
###

if [ "${GAIA_THIRD_PARTY_QT_FOUND}" = true ]; then

	# unload any previous qt versions if DSI host
	if [ "${GAIA_FOUND_DSI_HOST}" = true ]; then

		module unload qt-framework

	fi

	# internal
	GAIA_THIRD_PARTY_QT_ROOT=$GAIA_THIRD_PARTY_HOME/qt-$GAIA_THIRD_PARTY_QT_VERSION
	GAIA_THIRD_PARTY_QT_INCLUDEDIR=$GAIA_THIRD_PARTY_QT_ROOT/include
	GAIA_THIRD_PARTY_QT_LIBRARYDIR=$GAIA_THIRD_PARTY_QT_ROOT/lib
	GAIA_THIRD_PARTY_QT_BINARYDIR=$GAIA_THIRD_PARTY_QT_ROOT/bin

	# info
	GAIA_ECOSYSTEM_DETAIL+="\n\t|\t* Qt v.$GAIA_THIRD_PARTY_QT_VERSION"

	# env
	QTDIR=$GAIA_THIRD_PARTY_QT_ROOT
	QTINC=$GAIA_THIRD_PARTY_QT_INCLUDEDIR
	QTLIB=$GAIA_THIRD_PARTY_QT_LIBRARYDIR
	CPATH=$GAIA_THIRD_PARTY_QT_INCLUDEDIR:$CPATH
	PATH=$GAIA_THIRD_PARTY_QT_BINARYDIR:$PATH
	LD_LIBRARY_PATH=$GAIA_THIRD_PARTY_QT_LIBRARYDIR:$LD_LIBRARY_PATH

	# export
	export QTDIR QTINC QTLIB

	# clean
	unset GAIA_THIRD_PARTY_QT_ROOT
	unset GAIA_THIRD_PARTY_QT_LIBRARYDIR
	unset GAIA_THIRD_PARTY_QT_INCLUDEDIR
	unset GAIA_THIRD_PARTY_QT_BINARYDIR

fi

###################################################################
# QT Creator
###

if [ "${GAIA_THIRD_PARTY_QTCREATOR_FOUND}" = true ]; then

	# internal
	GAIA_THIRD_PARTY_QTCREATOR_ROOT=$GAIA_THIRD_PARTY_HOME/qt-creator-$GAIA_QTCREATOR_VERSION
	GAIA_THIRD_PARTY_QTCREATOR_LIBRARYDIR=$GAIA_THIRD_PARTY_QTCREATOR_ROOT/lib
	GAIA_THIRD_PARTY_QTCREATOR_BINARYDIR=$GAIA_THIRD_PARTY_QTCREATOR_ROOT/bin

	# info
	GAIA_ECOSYSTEM_DETAIL+="\n\t|\t* Qt Creator v.$GAIA_THIRD_PARTY_QTCREATOR_VERSION"

	# env
	PATH=$GAIA_THIRD_PARTY_QTCREATOR_BINARYDIR:$PATH
	LD_LIBRARY_PATH=$GAIA_THIRD_PARTY_QTCREATOR_LIBRARYDIR:$LD_LIBRARY_PATH

	# clean
	unset GAIA_THIRD_PARTY_QTCREATOR_ROOT
	unset GAIA_THIRD_PARTY_QTCREATOR_LIBRARYDIR
	unset GAIA_THIRD_PARTY_QTCREATOR_BINARYDIR

fi

#== EOF
