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
	for dirname in $(find $GAIA_THIRD_PARTY_HOME/$1-* -maxdepth 0 -type d 2>/dev/null | awk -F"/" '{print $NF}'); do

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
	
} # function declare_version()

# list all directories under home
directories=$(find $GAIA_THIRD_PARTY_HOME/* -maxdepth 0 -type d 2>/dev/null | awk -F"/" '{print $NF}' | awk -F"-" '{print $1}')
if [ ! -z  ${directories+x} ]; then

	# remove duplicate names if any
	# [ https://stackoverflow.com/questions/13648410/how-can-i-get-unique-values-from-an-array-in-bash ]
	unique_directories=$(tr ' ' '\n' <<< "${directories[@]}" | sort -u | tr '\n' ' ')

	# then declare each independant version
	for dirname in $unique_directories; do
		
		declare_version "$dirname"

	done

fi

return 0
# == EOF
