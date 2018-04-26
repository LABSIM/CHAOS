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
BUILD_DIR=/tmp/GAIA/$(whoami)/build/cmake

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
echo "                        CMake                           "
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "wget https://cmake.org/files/v$CMAKE_INSTALL_TARGET_MAJ_VER.$CMAKE_INSTALL_TARGET_MIN_VER/cmake-$CMAKE_INSTALL_TARGET_VERSION.tar.gz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tTelechargement de CMake $CMAKE_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - CMake $CMAKE_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo -e "\t==> OK"

echo "#!/bin/bash" > exec.sh
echo "tar -xzvf cmake-$CMAKE_INSTALL_TARGET_VERSION.tar.gz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tDecompression de CMake $CMAKE_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - CMake $CMAKE_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo -e "\t==> OK"

cd cmake-*

# Cmake install or not ?
if hash cmake 2>/dev/null; then

	mkdir build
	cd build

	# cmake exist
	echo "#!/bin/bash" > exec.sh
	echo "cmake -DCMAKE_INSTALL_PREFIX=$GAIA_THIRD_PARTY_HOME/cmake-$CMAKE_INSTALL_TARGET_VERSION .." >> exec.sh
	echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
	echo -ne "\tCMake de cmake $CMAKE_INSTALL_TARGET_VERSION (Inception !)... "
	chmod u+x exec.sh
	gnome-terminal --working-directory $PWD --title="LABSIM - CMake $CMAKE_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
	sleep 0.2
	PID=$(pgrep exec.sh)
	wait_for_PID $PID
	echo -e "\t==> OK"

else

	# no cmake builtin -> bootstrap
	echo "#!/bin/bash" > exec.sh
	echo "./bootstrap --prefix=$GAIA_THIRD_PARTY_HOME/cmake-$CMAKE_INSTALL_TARGET_VERSION --parallel=4" >> exec.sh
	echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
	echo -ne "\tBootstrap de cmake $CMAKE_INSTALL_TARGET_VERSION ... "
	chmod u+x exec.sh
	gnome-terminal --working-directory $PWD --title="LABSIM - CMake $CMAKE_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
	sleep 0.2
	PID=$(pgrep exec.sh)
	wait_for_PID $PID
	echo -e "\t==> OK"

fi

echo "#!/bin/bash" > exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCompilation de cmake $CMAKE_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - CMake $CMAKE_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo -e "\t==> OK"

echo "#!/bin/bash" > exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tInstallation de cmake $CMAKE_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - CMake $CMAKE_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo -e "\t==> OK"

echo "#!/bin/bash" > exec.sh
echo "cp -r $CURRENT_DIR/../../../../etc/cmake/* $GAIA_THIRD_PARTY_HOME/cmake-$CMAKE_INSTALL_TARGET_VERSION/share/cmake-$CMAKE_INSTALL_TARGET_MAJ_VER.$CMAKE_INSTALL_TARGET_MIN_VER/Modules/" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCopie des Module CMake specifiques (COTIRE, Find*) ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - CMake $CMAKE_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
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

