#!/usr/bin/env bash

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

# shell standard configuration
if test "$BASH" = "" || "$BASH" -uc 'a=();true "${a[@]}"' 2>/dev/null; then
	# Bash 4.4, Zsh
	set -euo pipefail
else
	# Bash 4.3 and older chokes on empty arrays with set -u.
	set -eo pipefail
fi
shopt -s nullglob globstar

# variables
CURRENT_DIR=$PWD
BUILD_DIR=/tmp/GAIA/$(whoami)/build/osgearth

# source distribution configured versions 
source /tmp/GAIA/$(whoami)/dist-config-versions.conf.sh
source $GAIA_ROOT/script/sh/function/pid.conf.sh

OSGEARTH_INSTALL_TARGET_MAJ_VER=2
OSGEARTH_INSTALL_TARGET_MIN_VER=9
OSGEARTH_INSTALL_TARGET_PATCH_VER=0
OSGEARTH_INSTALL_TARGET_VERSION=$OSGEARTH_INSTALL_TARGET_MAJ_VER.$OSGEARTH_INSTALL_TARGET_MIN_VER.$OSGEARTH_INSTALL_TARGET_PATCH_VER

PROTOBUF_INSTALL_TARGET_MAJ_VER=3
PROTOBUF_INSTALL_TARGET_MIN_VER=5
PROTOBUF_INSTALL_TARGET_PATCH_VER=1
PROTOBUF_INSTALL_TARGET_VERSION=$PROTOBUF_INSTALL_TARGET_MAJ_VER.$PROTOBUF_INSTALL_TARGET_MIN_VER.$PROTOBUF_INSTALL_TARGET_PATCH_VER

GDAL_INSTALL_TARGET_MAJ_VER=2
GDAL_INSTALL_TARGET_MIN_VER=2
GDAL_INSTALL_TARGET_PATCH_VER=4
GDAL_INSTALL_TARGET_VERSION=$GDAL_INSTALL_TARGET_MAJ_VER.$GDAL_INSTALL_TARGET_MIN_VER.$GDAL_INSTALL_TARGET_PATCH_VER

GEOS_INSTALL_TARGET_MAJ_VER=3
GEOS_INSTALL_TARGET_MIN_VER=6
GEOS_INSTALL_TARGET_PATCH_VER=2
GEOS_INSTALL_TARGET_VERSION=$GEOS_INSTALL_TARGET_MAJ_VER.$GEOS_INSTALL_TARGET_MIN_VER.$GEOS_INSTALL_TARGET_PATCH_VER

# build local dir & remove previous
#if [ -d "$BUILD_DIR" ]; then 
#	rm -rf $BUILD_DIR
#fi
#mkdir --parents $BUILD_DIR
cd $BUILD_DIR

echo; echo "## BEGIN"; echo

echo "########################################################"
echo "                      osgEarth                    "
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "git clone --recursive https://github.com/gwaldron/osgearth.git" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCloning de osgEarth $OSGEARTH_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - osgEarth $OSGEARTH_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

cd osgearth

#echo "#!/bin/bash" > exec.sh
#echo "git checkout tags/osgearth-$OSGEARTH_INSTALL_TARGET_MAJ_VER.$OSGEARTH_INSTALL_TARGET_MIN_VER" >> exec.sh
#echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
#echo -ne "\tCheckout du release tag pour osgEarth $OSGEARTH_INSTALL_TARGET_VERSION ... "
#chmod u+x exec.sh
#gnome-terminal --working-directory $PWD --title="LABSIM - osgEarth $OSGEARTH_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
#sleep 0.2
#PID=$(pgrep exec.sh)
#wait_for_PID $PID
#echo "OK"

mkdir build
cd build

echo "#!/bin/bash" > exec.sh
echo "cmake -DCMAKE_INSTALL_PREFIX=$GAIA_THIRD_PARTY_HOME/osgearth-$OSGEARTH_INSTALL_TARGET_VERSION -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=$GAIA_THIRD_PARTY_PROTOBUF_ROOT -DGDAL_DIR=$GAIA_THIRD_PARTY_HOME/gdal-$GDAL_INSTALL_TARGET_VERSION -DGEOS_DIR=$GAIA_THIRD_PARTY_HOME/geos-$GEOS_INSTALL_TARGET_VERSION .." >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tConfiguration de osgEarth $OSGEARTH_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - osgEarth $OSGEARTH_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make -j6" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCompilation de osgEarth $OSGEARTH_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - osgEarth $OSGEARTH_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tInstallation de osgEarth $OSGEARTH_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - osgEarth $OSGEARTH_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "########################################################"
echo -ne "\tSuppression du repertoire temporaire ..."
cd $CURRENT_DIR
rm -rf $BUILD_DIR
echo "OK"
echo "########################################################"

echo; echo "## END"; echo

