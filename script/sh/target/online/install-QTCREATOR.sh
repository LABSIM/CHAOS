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
BUILD_DIR=/tmp/GAIA/$(whoami)/build/qt-creator

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
echo "                     Qt Creator                         "
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "git clone --recursive -b $QTCREATOR_INSTALL_TARGET_MAJ_VER.$QTCREATOR_INSTALL_TARGET_MIN_VER https://code.qt.io/qt-creator/qt-creator.git" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCloning de Qt Creator $QTCREATOR_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - Qt Creator $QTCREATOR_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo -e "\t==> OK"

cd qt-creator-*
mkdir build
cd build

echo "#!/bin/bash" > exec.sh
echo "qmake ../qt-creator/qtcreator.pro" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh-stl
echo -ne "\tConfiguration de Qt Creator $QTCREATOR_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - Qt Creator $QTCREATOR_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo -e "\t==> OK"

echo "#!/bin/bash" > exec.sh
echo "make -j6" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCompilation de Qt Creator $QTCREATOR_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - Qt Creator $QTCREATOR_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo -e "\t==> OK"

echo "#!/bin/bash" > exec.sh
echo "make install INSTALL_ROOT=$GAIA_THIRD_PARTY_HOME/qt-creator-$QTCREATOR_INSTALL_TARGET_VERSION" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tInstallation de Qt Creator $QTCREATOR_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - Qt Creator $QTCREATOR_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
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
