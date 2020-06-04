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

# debug
set -x

# print
echo "Bootstraping GAIA..."

# get the source dir --> [ https://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within ]
pushd . > /dev/null
SCRIPT_PATH="${BASH_SOURCE[0]}"
if ([ -h "${SCRIPT_PATH}" ]); then
  while([ -h "${SCRIPT_PATH}" ]); do cd `dirname "$SCRIPT_PATH"`; 
  SCRIPT_PATH=`readlink "${SCRIPT_PATH}"`; done
fi
cd `dirname ${SCRIPT_PATH}` > /dev/null
SCRIPT_PATH=`pwd`;
popd  > /dev/null

# export GAIA root dir
export GAIA_ROOT="$( cd "$(dirname "$SCRIPT_PATH/")" ; pwd )"
echo "- found GAIA_ROOT ==> [${GAIA_ROOT}]"

# install perl (at least)
echo "- installing PERL v5.26.1"
sh ${GAIA_ROOT}/script/sh/target/install-PERL.sh 5 26 1

# setup
echo "- setup GAIA environment"
cat ${GAIA_ROOT}/script/sh/GAIA.bashrc >> ~/.bashrc

# install perl (at least)
echo "- check GAIA config"
source ~/.bashrc && gaia