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
echo "- setup GAIA"
cat ${GAIA_ROOT}/script/sh/GAIA.bashrc >> ~/.bashrc

# required PERL + CPAN module
echo "- requirement : installing perl v5.30.3 & CPAN modules"
#/bin/bash -c "source ${GAIA_ROOT}/script/sh/GAIA.bashrc && ${GAIA_ROOT}/script/sh/target/install-PERL.sh 5 30 3"

# running gaia with arg
echo "- running GAIA [$@]"
/bin/bash -c 'source ${GAIA_ROOT}/script/sh/GAIA.bashrc && echo "$0 $@"' /bin/bash "$@"