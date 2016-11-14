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

# source current versions 
declare LABSIM_DRI_MASK=$(( 1 << 0 ))
declare LABSIM_COMMON_MASK=$(( 1 << 1 ))
declare LABSIM_COLOSSES_MASK=$(( 1 << 2 ))
declare LABSIM_OLYMPIENS_MASK=$(( 1 << 3 ))
declare LABSIM_TITANS_MASK=$(( 1 << 4 ))
declare LABSIM_CONTRACT_MASK=$(( 1 << 5 ))

export LABSIM_DEV_ID=$LABSIM_COMMON_MASK

source ../../routine/versions.sh
source ../../routine/wait_for_PID.sh

echo; echo "## BEGIN"; echo

echo "################################################"
echo " Nettoyage des fichiers de configuration ld "
echo "################################################"

echo -e "\tSuppression de /etc/ld.so.conf.d/gmp-$GMP_VERSION.conf"
rm -f  /etc/ld.so.conf.d/gmp-$GMP_VERSION.conf

echo -e "\tSuppression de /etc/ld.so.conf.d/mpfr-$MPFR_VERSION.conf"
rm -f /etc/ld.so.conf.d/mpfr-$MPFR_VERSION.conf

echo -e "\tSuppression de /etc/ld.so.conf.d/mpc-$MPC_VERSION.conf"
rm -f /etc/ld.so.conf.d/mpc-$MPC_VERSION.conf

echo -e "\tSuppression de /etc/ld.so.conf.d/autogen-$AUTOGEN_VERSION.conf"
rm -f /etc/ld.so.conf.d/autogen-$AUTOGEN_VERSION.conf

echo -e "\tSuppression de /etc/ld.so.conf.d/gcc-$GCC_VERSION.conf"
rm -f /etc/ld.so.conf.d/gcc-$GCC_VERSION.conf

echo "#############################################"
echo "  Reconfiguration de ld" 
echo "#############################################"

ldconfig

echo "#############################################"
echo "  Reset local des variables d'environments" 
echo "#############################################"

# run new local terminal to install gcc
sudo -u $1 env DEVTK_REQUIRE_CLEAN_INSTALL_ENVIRONMENT=1 bash

echo; echo "## END"; echo


