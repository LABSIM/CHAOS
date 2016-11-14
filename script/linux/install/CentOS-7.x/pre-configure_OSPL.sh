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

if [ $(whoami) != "root" ] 
then
  echo
  echo "##############################################"
  echo " Vous devez etre root pour executer ce script "
  echo "##############################################"
  echo
  exit
fi

if [ $# != 1 ]
then
  echo
  echo "##############################################"
  echo " Usage : COMMAND [USER_TARGETED]"
  echo "##############################################"
  echo
  exit
fi

# build temporary progiciels home directory
PRO_HOME=/home/$1/Progiciels
if [ ! -d "$PRO_HOME" ]; then
  echo
  echo "##############################################"
  echo " Le répertoire $PRO_HOME n'existe pas, mkdir ? "
  echo "##############################################"
  echo
  exit
fi

echo "#############################################"
echo "  Run a clean DDS-readymade shell" 
echo "#############################################"

# run new local terminal to install ospl
sudo -u $1 env DEVTK_REQUIRE_CLEAN_DDS_INSTALL_ENVIRONMENT=1 bash

echo; echo "## END"; echo


