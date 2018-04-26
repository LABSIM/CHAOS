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
BUILD_DIR=/tmp/GAIA/$(whoami)/build/qt

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
echo "                         Qt                             "
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "git clone https://code.qt.io/qt/qt5.git" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCloning de Qt $QT_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - Qt $QT_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo -e "\t==> OK"

cd qt5

echo "#!/bin/bash" > exec.sh
echo "git checkout $QT_INSTALL_TARGET_VERSION" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCheckout de la branche Qt $QT_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - Qt $QT_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo -e "\t==> OK"

echo "#!/bin/bash" > exec.sh
echo "git submodule update --init --recursive" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tConfiguration des submodules de Qt $QT_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - Qt $QT_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo -e "\t==> OK"

mkdir build
cd build

echo "#!/bin/bash" > exec.sh
echo "../configure -prefix $GAIA_THIRD_PARTY_HOME/qt-$QT_INSTALL_TARGET_VERSION -platform linux-g++-64 -verbose -opensource -confirm-license -release -c++std c++14 -shared -reduce-exports -reduce-relocations -optimized-qmake -optimized-tools -no-use-gold-linker -no-avx2 -no-cups -no-pch -no-qt3d-input -opengl desktop -openssl -pkg-config -qml-debug -gui -widgets -accessibility -skip webengine -skip webchannel -skip webglplugin -skip websockets -skip webview -skip networkauth -skip purchasing -skip connectivity -skip wayland -skip gamepad -skip sensors -skip location -skip serialbus -skip serialport -nomake tests -compile-examples" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh-stl
echo -ne "\tConfiguration de Qt $QT_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - Qt $QT_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo -e "\t==> OK"

echo "#!/bin/bash" > exec.sh
echo "make -j6" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCompilation de Qt $QT_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - Qt $QT_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
wait_for_PID $(pgrep exec.sh)
echo -e "\t==> OK"

echo "#!/bin/bash" > exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tInstallation de Qt $QT_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - Qt $QT_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo -e "\t==> OK"

echo "########################################################"
echo -ne "\tSuppression du repertoire temporaire ..."
cd $CURRENT_DIR
rm -rf $BUILD_DIR
echo "OK"
echo "########################################################"

echo; echo "## END"; echo

