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

# get current directory
current_dir=$PWD

# source user configured versions 
source user-config-versions.sh
source ../../routine/wait_for_PID.sh

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

# go to dir
cd /home/$1
mkdir tritoninst
cd tritoninst

echo; echo "## BEGIN"; echo

echo "########################################################"
echo "  Triton : Copie & Decompression du/des package(s)"
echo "########################################################"


echo -ne "\tCopie du SDK Triton $TRITON_INSTALL_TARGET_VERSION ... "
cp /data/CentOS_6.3/sundog/install-triton-fullsource.run .
echo "OK"

echo -ne "\tExecution du script du SDK Triton $TRITON_INSTALL_TARGET_VERSION ... "
sh install-triton-fullsource.run
echo "OK"

cd ..

echo -ne "\tChangement des droits sur le SDK Triton $TRITON_INSTALL_TARGET_VERSION ... "
chown $1 -R tritoninst
chgrp $1 -R tritoninst
echo "OK"

echo; echo "## END"; echo

exit
