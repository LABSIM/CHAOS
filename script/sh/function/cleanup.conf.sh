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

#################################################
# cleanup.conf.sh
#
# On place ici le nettoyage des variables 
#
# (Valentines's Day)
# 14/02/2012 - Kinani Nawfel
#

function unset_version() 
{
	local found_ref=GAIA_THIRD_PARTY_$(echo "${1//-/_}" | tr '[:lower:]' '[:upper:]')_FOUND
	local major_ref=GAIA_THIRD_PARTY_$(echo "${1//-/_}" | tr '[:lower:]' '[:upper:]')_MAJ_VER
	local minor_ref=GAIA_THIRD_PARTY_$(echo "${1//-/_}" | tr '[:lower:]' '[:upper:]')_MIN_VER
	local patch_ref=GAIA_THIRD_PARTY_$(echo "${1//-/_}" | tr '[:lower:]' '[:upper:]')_PATCH_VER
	local version_ref=GAIA_THIRD_PARTY_$(echo "${1//-/_}" | tr '[:lower:]' '[:upper:]')_VERSION

	# unset
	unset "${found_ref}"
	unset "${major_ref}"
	unset "${minor_ref}"
	unset "${patch_ref}"
	unset "${version_ref}"

} # unset_version()

function clean_version() {

	# common
	unset_version "binutils"
	unset_version "mpc"
	unset_version "mpfr"
	unset_version "gmp"
	unset_version "isl"
	unset_version "autogen"
	unset_version "gcc"
	unset_version "gdb"
	unset_version "perl"
	unset_version "doxygen"
	unset_version "xercesc"
	unset_version "cmake"
	unset_version "boost"

	# IG
	unset_version "osg"
	unset_version "silverlining"
	unset_version "fftss"
	unset_version "triton"

	# VR-AR
	unset_version "opencv"
	unset_version "hidapi"
	unset_version "jsoncpp"
	unset_version "osvr-libfunctionality"
	unset_version "osvr-core"
	unset_version "osvr-display"

	# Simulation network
	unset_version "protobuf"
	unset_version "grpc"
	unset_version "gsoap"
	unset_version "opensplice"

	# UI
	unset_version "qt"
	unset_version "qt-creator"

	# ...
	unset_version "cegui"

} # clean_version()

# call
clean_version

# http://unix.stackexchange.com/questions/40749/remove-duplicate-path-entries-with-awk-command ... What else ?...

if [ -n "$PATH" ]; then
	old_PATH=$PATH:; PATH=
	while [ -n "$old_PATH" ]; do
		x=${old_PATH%%:*}        	# the first remaining entry
		case $PATH: in
			*:"$x":*) ;;         	# already there
			*) PATH=$PATH:$x;;   	# not there yet
		esac
		old_PATH=${old_PATH#*:}
	done
	PATH=${PATH#:}
	unset old_PATH x
fi

if [ -n "$LD_LIBRARY_PATH" ]; then
	old_LD_LIBRARY_PATH=$LD_LIBRARY_PATH:; LD_LIBRARY_PATH=
	while [ -n "$old_LD_LIBRARY_PATH" ]; do
		x=${old_LD_LIBRARY_PATH%%:*}        			# the first remaining entry
		case $LD_LIBRARY_PATH: in
			*:"$x":*) ;;         				# already there
			*) LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$x;;  	# not there yet
		esac
		old_LD_LIBRARY_PATH=${old_LD_LIBRARY_PATH#*:}
	done
	LD_LIBRARY_PATH=${LD_LIBRARY_PATH#:}
	unset old_LD_LIBRARY_PATH x
fi

if [ -n "$CPATH" ]; then
	old_CPATH=$CPATH:; CPATH=
	while [ -n "$old_CPATH" ]; do
		x=${old_CPATH%%:*}        	# the first remaining entry
		case $CPATH: in
			*:"$x":*) ;;         	# already there
			*) CPATH=$CPATH:$x;;   	# not there yet
		esac
		old_CPATH=${old_CPATH#*:}
	done
	CPATH=${CPATH#:}
	unset old_CPATH x
fi

if [ -n "$PKG_CONFIG_PATH" ]; then
	old_PKG_CONFIG_PATH=$PKG_CONFIG_PATH:; PKG_CONFIG_PATH=
	while [ -n "$old_PKG_CONFIG_PATH" ]; do
		x=${old_PKG_CONFIG_PATH%%:*}        			# the first remaining entry
		case $PKG_CONFIG_PATH: in
			*:"$x":*) ;;         				# already there
			*) PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$x;;   	# not there yet
		esac
		old_PKG_CONFIG_PATH=${old_PKG_CONFIG_PATH#*:}
	done
	PKG_CONFIG_PATH=${PKG_CONFIG_PATH#:}
	unset old_PKG_CONFIG_PATH x
fi

# == EOF
