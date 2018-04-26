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
# versions.conf.sh
#
# On place ici chacune des versions des outils utilisés 
#
# (Valentines's Day)
# 14/02/2012 - Kinani Nawfel
#

function declare_version() 
{
	local found_version=0
	local major_version=0
	local minor_version=0
	local patch_version=0

	local found_ref=GAIA_THIRD_PARTY_$(echo "${1//-/_}" | tr '[:lower:]' '[:upper:]')_FOUND
	local major_ref=GAIA_THIRD_PARTY_$(echo "${1//-/_}" | tr '[:lower:]' '[:upper:]')_MAJ_VER
	local minor_ref=GAIA_THIRD_PARTY_$(echo "${1//-/_}" | tr '[:lower:]' '[:upper:]')_MIN_VER
	local patch_ref=GAIA_THIRD_PARTY_$(echo "${1//-/_}" | tr '[:lower:]' '[:upper:]')_PATCH_VER
	local version_ref=GAIA_THIRD_PARTY_$(echo "${1//-/_}" | tr '[:lower:]' '[:upper:]')_VERSION

	# find highest version
	for dirname in $(ls -d $GAIA_THIRD_PARTY_HOME/$1-* 2>/dev/null); do

		local tmp_version=$(echo $dirname | awk -F"-" '{print $NF}')
		local tmp_major_version=$(echo $tmp_version | awk -F"." '{print $1}')
		local tmp_minor_version=$(echo $tmp_version | awk -F"." '{print $2}')
		local tmp_patch_version=$(echo $tmp_version | awk -F"." '{print $3}')

		if [ "$tmp_major_version" -gt "$major_version" ]; then
			major_version=$tmp_major_version
			minor_version=$tmp_minor_version
			patch_version=$tmp_patch_version
		else
			if [ "$tmp_minor_version" -gt "$minor_version" ]; then
				minor_version=$tmp_minor_version
				patch_version=$tmp_patch_version
			else
				if [ "$tmp_patch_version" -gt "$patch_version" ]; then
					patch_version=$tmp_patch_version
				fi
			fi
		fi

	done

	# assign

	if [ -d "$GAIA_THIRD_PARTY_HOME/$1-$major_version.$minor_version.$patch_version" ]; then

		printf -v $found_ref true
		printf -v $major_ref "$major_version"
		printf -v $minor_ref "$minor_version"
		printf -v $patch_ref "$patch_version"
		printf -v $version_ref "$major_version.$minor_version.$patch_version"

	else

		printf -v $found_ref false

	fi
	
} # declare_version()

# Then split then into version

function find_version()  {

	# common
	declare_version "binutils"
	declare_version "mpc"
	declare_version "mpfr"
	declare_version "gmp"
	declare_version "isl"
	declare_version "autogen"
	declare_version "gcc"
	declare_version "gdb"
	declare_version "perl"
	declare_version "doxygen"
	declare_version "xercesc"
	declare_version "cmake"
	declare_version "boost"

	# IG
	declare_version "osg"
	declare_version "silverlining"
	declare_version "fftss"
	declare_version "triton"

	# VR-AR
	declare_version "opencv"
	declare_version "hidapi"
	declare_version "jsoncpp"
	declare_version "osvr-libfunctionality"
	declare_version "osvr-core"
	declare_version "osvr-display"

	# Simulation network
	declare_version "protobuf"
	declare_version "grpc"
	declare_version "gsoap"
	declare_version "opensplice"

	# UI
	declare_version "qt"
	declare_version "qt-creator"

	# ...
	declare_version "cegui"

} # find_version() 

# call
find_version

# == EOF

