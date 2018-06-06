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

# go to dir
cd /home/$(whoami)
mkdir cmakeinst
cd cmakeinst

echo; echo "## BEGIN"; echo

echo "########################################################"
echo "  Decompression du/des package(s)"
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "tar -xzvf /data/CentOS_7.x/archive/cmake-$CMAKE_INSTALL_TARGET_VERSION.tar.gz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tDecompression de cmake $CMAKE_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "########################################################"
echo " Bootstrap, build & install"
echo "########################################################"

cd cmake-*

# Cmake install or not ?
if hash cmake 2>/dev/null; then
	# cmake exist
	echo "#!/bin/bash" > exec.sh
	echo "cmake -DCMAKE_INSTALL_PREFIX=/home/$(whoami)/Progiciels/cmake-$CMAKE_INSTALL_TARGET_VERSION ." >> exec.sh
	echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
	echo -ne "\tCMake de cmake $CMAKE_INSTALL_TARGET_VERSION (Inception !)... "
	chmod u+x exec.sh
	gnome-terminal --working-directory $PWD --command "./exec.sh" --window
	sleep 0.2
	PID=$(pgrep exec.sh)
	wait_for_PID $PID
	echo "OK"
else
	# no cmake builtin -> bootstrap
	echo "#!/bin/bash" > exec.sh
	echo "./bootstrap --prefix=/home/$(whoami)/Progiciels/cmake-$CMAKE_INSTALL_TARGET_VERSION --parallel=4" >> exec.sh
	echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
	echo -ne "\tBootstrap de cmake $CMAKE_INSTALL_TARGET_VERSION ... "
	chmod u+x exec.sh
	gnome-terminal --working-directory $PWD --command "./exec.sh" --window
	sleep 0.2
	PID=$(pgrep exec.sh)
	wait_for_PID $PID
	echo "OK"
fi

echo "#!/bin/bash" > exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCompilation de cmake $CMAKE_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tInstallation de cmake $CMAKE_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "########################################################"
echo " Import des propriétés LABSIM"
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "cp -r $current_dir/../../../../etc/cmake/* /home/$(whoami)/Progiciels/cmake-$CMAKE_INSTALL_TARGET_VERSION/share/cmake-$CMAKE_INSTALL_TARGET_MAJ_VER.$CMAKE_INSTALL_TARGET_MIN_VER/Modules/" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCopie des Module CMake specifiques (COTIRE, FindOpenSpliceDDS, FindSimpleDDS, FindLabsim* & KRONOS-DDS spec.) ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "########################################################"
echo "  Suppression du repertoire temporaire"
cd $current_dir
rm -rf /home/$(whoami)/cmakeinst
echo "########################################################"

echo; echo "## END"; echo

