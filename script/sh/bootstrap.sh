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

# get the source dir --> [ https://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within ]
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )/../.." >/dev/null 2>&1 && pwd )"

# export GAIA root dir
export GAIA_ROOT="${DIR}"
echo "- setup GAIA_ROOT [${GAIA_ROOT}]"

# setup
echo "- configure GAIA"
cat ${GAIA_ROOT}/script/sh/GAIA.bashrc >> ~/.bashrc

# required PERL + CPAN module
local perl_required_major_version="5"
local perl_required_minor_version="30"
local perl_required_patch_version="0"
local perl_required_version="v${perl_required_major_version}.${perl_required_minor_version}.${perl_required_patch_version}"

# has PERL ?
if perl < /dev/null > /dev/null 2>&1 ; then

  # check perl version
  local perl_major_version=$(perl -e 'print $^V;' | awk -F"v" '{print $NF}' | awk -F"." '{print $1}')
	local perl_minor_version=$(perl -e 'print $^V;' | awk -F"v" '{print $NF}' | awk -F"." '{print $2}')
	local perl_patch_version=$(perl -e 'print $^V;' | awk -F"v" '{print $NF}' | awk -F"." '{print $3}')

  if [ "$perl_major_version" -lt "$perl_required_major_version" ] || [ "$perl_minor_version" -lt "$perl_required_minor_version" ] || [ "$perl_patch_version" -lt "$perl_required_patch_version" ]; then

    #  perl, install
    echo "- requirement : found installed perl $(perl -e 'print $^V;') but required is ${perl_required_version}"
    /bin/bash -c 'source ${GAIA_ROOT}/script/sh/GAIA.bashrc && ${0} ${1+"$@"}' ${GAIA_ROOT}/script/sh/target/install-PERL.sh ${perl_required_major_version} ${perl_required_minor_version} ${perl_required_patch_version}

  # PERL == ok
  else
    
    # has CPANM ?
    if cpanm < /dev/null > /dev/null 2>&1 ; then

      # found CPANM, check module
      echo "- requirement : found perl $(perl -e 'print $^V;') with CPANM, just check required PERL modules..."

    else

      # no CPANM, install it
      echo "- requirement : found perl $(perl -e 'print $^V;') but not CPANM, installing it"

    fi
  
    /bin/bash -c 'source ${GAIA_ROOT}/script/sh/GAIA.bashrc && ${0} ${1+"$@"}' ${GAIA_ROOT}/script/sh/target/install-CPANM.sh ${perl_required_major_version} ${perl_required_minor_version} ${perl_required_patch_version}
    
  fi

else

  # no PERL, install it
  echo "- requirement : installing perl ${perl_required_version} & CPANM modules"
  /bin/bash -c 'source ${GAIA_ROOT}/script/sh/GAIA.bashrc && ${0} ${1+"$@"}' ${GAIA_ROOT}/script/sh/target/install-PERL.sh ${perl_required_major_version} ${perl_required_minor_version} ${perl_required_patch_version}

fi

# running gaia with arg
echo "- running GAIA.pl [$@]"
/bin/bash -c 'source ${GAIA_ROOT}/script/sh/GAIA.bashrc && ${0} ${1+"$@"}' perl ${GAIA_ROOT}/GAIA.pl "$@"