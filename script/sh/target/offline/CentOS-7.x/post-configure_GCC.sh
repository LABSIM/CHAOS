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

target=$1

# get current directory
current_dir=$PWD

# source user configured versions 
source user-config-versions.sh
source ../../routine/wait_for_PID.sh

# go to dir
cd /home/${target}/gccinst

echo; echo "## BEGIN"; echo

echo "################################################"
echo " Creation des fichiers de configuration pour ld "
echo "################################################"
echo -e "\tCreation de /etc/ld.so.conf.d/gmp-$GMP_INSTALL_TARGET_VERSION.conf"
echo "/home/${target}/Progiciels/gmp-$GMP_INSTALL_TARGET_VERSION/lib" > /etc/ld.so.conf.d/gmp-$GMP_INSTALL_TARGET_VERSION.conf

echo -e "\tCreation de /etc/ld.so.conf.d/mpfr-$MPFR_INSTALL_TARGET_VERSION.conf"
echo "/home/${target}/Progiciels/mpfr-$MPFR_INSTALL_TARGET_VERSION/lib" > /etc/ld.so.conf.d/mpfr-$MPFR_INSTALL_TARGET_VERSION.conf

echo -e "\tCreation de /etc/ld.so.conf.d/mpc-$MPC_INSTALL_TARGET_VERSION.conf"
echo "/home/${target}/Progiciels/mpc-$MPC_INSTALL_TARGET_VERSION/lib" > /etc/ld.so.conf.d/mpc-$MPC_INSTALL_TARGET_VERSION.conf

echo -e "\tCreation de /etc/ld.so.conf.d/autogen-$AUTOGEN_INSTALL_TARGET_VERSION.conf"
echo "/home/${target}/Progiciels/autogen-$AUTOGEN_INSTALL_TARGET_VERSION/lib" > /etc/ld.so.conf.d/autogen-$AUTOGEN_INSTALL_TARGET_VERSION.conf

echo -e "\tCreation de /etc/ld.so.conf.d/gcc-$GCC_INSTALL_TARGET_VERSION.conf"
GCJ=$(ls /home/${target}/Progiciels/gcc-$GCC_INSTALL_TARGET_VERSION/lib | grep gcj-$GCC_INSTALL_TARGET_VERSION)
echo "/home/${target}/Progiciels/gcc-$GCC_INSTALL_TARGET_VERSION/libexec/gcc/x86_64-unknown-linux-gnu/$GCC_INSTALL_TARGET_VERSION" > /etc/ld.so.conf.d/gcc-$GCC_INSTALL_TARGET_VERSION.conf
echo "/home/${target}/Progiciels/gcc-$GCC_INSTALL_TARGET_VERSION/lib/../lib64" >> /etc/ld.so.conf.d/gcc-$GCC_INSTALL_TARGET_VERSION.conf
echo "/home/${target}/Progiciels/gcc-$GCC_INSTALL_TARGET_VERSION/lib/../lib64/$GCJ" >> /etc/ld.so.conf.d/gcc-$GCC_INSTALL_TARGET_VERSION.conf
echo "/home/${target}/Progiciels/gcc-$GCC_INSTALL_TARGET_VERSION/lib/../lib" >> /etc/ld.so.conf.d/gcc-$GCC_INSTALL_TARGET_VERSION.conf
echo "/home/${target}/Progiciels/gcc-$GCC_INSTALL_TARGET_VERSION/lib/../lib/$GCJ" >> /etc/ld.so.conf.d/gcc-$GCC_INSTALL_TARGET_VERSION.conf
echo "/home/${target}/Progiciels/gcc-$GCC_INSTALL_TARGET_VERSION/lib/gcc/x86_64-unknown-linux-gnu/$GCC_INSTALL_TARGET_VERSION" >> /etc/ld.so.conf.d/gcc-$GCC_INSTALL_TARGET_VERSION.conf
echo "/home/${target}/Progiciels/gcc-$GCC_INSTALL_TARGET_VERSION/lib/gcc/x86_64-unknown-linux-gnu/$GCC_INSTALL_TARGET_VERSION/32" >> /etc/ld.so.conf.d/gcc-$GCC_INSTALL_TARGET_VERSION.conf

echo "################################################"
echo
echo "#############################################"
echo "  Deplacement des lib debug pour GDB de GCC"
mkdir -p /usr/share/gdb/auto-load/home/${target}/Progiciels/gcc-$GCC_INSTALL_TARGET_VERSION/{lib,lib64}
mv -f /home/${target}/Progiciels/gcc-$GCC_INSTALL_TARGET_VERSION/lib/libstdc++.so.*-gdb.py /usr/share/gdb/auto-load/home/${target}/Progiciels/gcc-$GCC_INSTALL_TARGET_VERSION/lib/.
mv -f /home/${target}/Progiciels/gcc-$GCC_INSTALL_TARGET_VERSION/lib64/libstdc++.so.*-gdb.py /usr/share/gdb/auto-load/home/${target}/Progiciels/gcc-$GCC_INSTALL_TARGET_VERSION/lib64/.
echo "#############################################"
echo
echo "#############################################"
echo "  Configuration de ld" 
ldconfig
echo "#############################################"
echo
echo "#############################################"
echo "  Suppression du repertoire temporaire" 
cd $current_dir
rm -rf /home/${target}/gccinst
echo "#############################################"

echo; echo "## END"; echo



