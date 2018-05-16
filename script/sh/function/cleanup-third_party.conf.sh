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

# list all directories under home
directories=$(find $GAIA_THIRD_PARTY_HOME/* -maxdepth 0 -type d 2>/dev/null | awk -F"/" '{print $NF}' | awk -F"-" '{print $1}')

#
# remove duplicate names if any
# [ https://stackoverflow.com/questions/13648410/how-can-i-get-unique-values-from-an-array-in-bash ]
#
unique_directories=$(tr ' ' '\n' <<< "${directories[@]}" | sort -u | tr '\n' ' ')

# then unset
for dirname in $unique_directories; do
	
	unset_version "$dirname"

done

return 0
# == EOF
