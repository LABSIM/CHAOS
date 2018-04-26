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

# variables
CURRENT_DIR=$PWD
BUILD_DIR=/tmp/GAIA/$(whoami)/build/gdb

# source distribution configured versions 
source /tmp/GAIA/$(whoami)/dist-config-versions.conf.sh
source $GAIA_ROOT/script/sh/function/pid.conf.sh

# build local dir & remove previous
if [ -d "$BUILD_DIR" ]; then 
	rm -rf $BUILD_DIR
fi
mkdir --parents $BUILD_DIR
cd $BUILD_DIR

echo; echo "## BEGIN"; echo

echo "########################################################"
echo "                           GDB                        "
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "wget https://ftp.gnu.org/gnu/gdb/gdb-$GDB_INSTALL_TARGET_MAJ_VER.$GDB_INSTALL_TARGET_MIN_VER.tar.xz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tTelechargement de GDB $GDB_INSTALL_TARGET_VERSION ..."
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - GDB $GDB_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo -e "\t==> OK"

echo "#!/bin/bash" > exec.sh
echo "tar -xvf gdb-$GDB_INSTALL_TARGET_MAJ_VER.$GDB_INSTALL_TARGET_MIN_VER.tar.xz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tDecompression de GDB $GDB_INSTALL_TARGET_VERSION ..."
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - GDB $GDB_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo -e "\t==> OK"

cd gdb-*
mkdir build 
cd build

echo "#!/bin/bash" > exec.sh
echo "../configure --prefix=$GAIA_THIRD_PARTY_HOME/gdb-$GDB_INSTALL_TARGET_VERSION --enable-gold=yes --enable-ld=yes --with-gmp=$GAIA_THIRD_PARTY_HOME/gmp-$GMP_INSTALL_TARGET_VERSION --with-mpc=$GAIA_THIRD_PARTY_HOME/mpc-$MPC_INSTALL_TARGET_VERSION --with-mpfr=$GAIA_THIRD_PARTY_HOME/mpfr-$MPFR_INSTALL_TARGET_VERSION --with-isl=$GAIA_THIRD_PARTY_HOME/isl-$ISL_INSTALL_TARGET_VERSION" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tConfiguration de GDB $GDB_INSTALL_TARGET_VERSION ..."
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - GDB $GDB_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo -e "\t==> OK"

echo "#!/bin/bash" > exec.sh
echo "make -j6" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tBuild de GDB $GDB_INSTALL_TARGET_VERSION ..."
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - GDB $GDB_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo -e "\t==> OK"

echo "#!/bin/bash" > exec.sh
echo "make check" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCheck de GDB $GDB_INSTALL_TARGET_VERSION ..."
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - GDB $GDB_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo -e "\t==> OK"

echo "#!/bin/bash" > exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tInstall de GDB $GDB_INSTALL_TARGET_VERSION ..."
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - GDB $GDB_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo -e "\t==> OK"

echo "########################################################"
echo -ne "\tSuppression du repertoire temporaire ... "
cd $CURRENT_DIR
rm -rf $BUILD_DIR
echo "OK"
echo "########################################################"

echo; echo "## END"; echo
