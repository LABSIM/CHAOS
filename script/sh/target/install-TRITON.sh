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
BUILD_DIR=/tmp/GAIA/$(whoami)/build/triton

# source distribution configured versions 
source /tmp/GAIA/$(whoami)/dist-config-versions.conf.sh
source $GAIA_ROOT/script/sh/function/pid.conf.sh

TRITON_INSTALL_TARGET_MAJ_VER=4
TRITON_INSTALL_TARGET_MIN_VER=0
TRITON_INSTALL_TARGET_PATCH_VER=4
TRITON_INSTALL_TARGET_VERSION=$TRITON_INSTALL_TARGET_MAJ_VER.$TRITON_INSTALL_TARGET_MIN_VER.$TRITON_INSTALL_TARGET_PATCH_VER

FFTSS_INSTALL_TARGET_MAJ_VER=3
FFTSS_INSTALL_TARGET_MIN_VER=0
FFTSS_INSTALL_TARGET_PATCH_VER=20071031
FFTSS_INSTALL_TARGET_VERSION=$FFTSS_INSTALL_TARGET_MAJ_VER.$FFTSS_INSTALL_TARGET_MIN_VER.$FFTSS_INSTALL_TARGET_PATCH_VER

# build local dir & remove previous
if [ -d "$BUILD_DIR" ]; then 
	rm -rf $BUILD_DIR
fi
mkdir --parents $BUILD_DIR
cd $BUILD_DIR

echo "########################################################"
echo "                     Sundog Triton                      "
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "cp -rvf /data/CentOS_6.x/sundog/triton-sdk-eval ." >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCopie de Triton $TRITON_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - Triton $TRITON_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

cd triton-*
mkdir build
cd build

echo "#!/bin/bash" > exec.sh
echo "cmake -DCMAKE_BUILD_TYPE=Realease -DCMAKE_INSTALL_PREFIX=$GAIA_THIRD_PARTY_HOME/triton-$TRITON_INSTALL_TARGET_VERSION -DFFTSS_INCLUDE_DIR=$GAIA_THIRD_PARTY_HOME/fftss-$FFTSS_INSTALL_TARGET_VERSION/include -DFFTSS_LIBRARY=$GAIA_THIRD_PARTY_HOME/fftss-$FFTSS_INSTALL_TARGET_VERSION/lib/libfftss.so .." >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tConfiguration de Triton $TRITON_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - Triton $TRITON_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make -j6" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tBuild de Triton $TRITON_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - Triton $TRITON_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

cd ..

echo "#!/bin/bash" > exec.sh
echo "mkdir $GAIA_THIRD_PARTY_HOME/triton-$TRITON_INSTALL_TARGET_VERSION" >> exec.sh
echo "mkdir $GAIA_THIRD_PARTY_HOME/triton-$TRITON_INSTALL_TARGET_VERSION/include" >> exec.sh
echo "cp -rvf Docs $GAIA_THIRD_PARTY_HOME/triton-$TRITON_INSTALL_TARGET_VERSION" >> exec.sh
echo "cp -rvf lib $GAIA_THIRD_PARTY_HOME/triton-$TRITON_INSTALL_TARGET_VERSION" >> exec.sh
echo "cp -rvf Public*/* $GAIA_THIRD_PARTY_HOME/triton-$TRITON_INSTALL_TARGET_VERSION/include" >> exec.sh
echo "cp -rvf Resources $GAIA_THIRD_PARTY_HOME/triton-$TRITON_INSTALL_TARGET_VERSION" >> exec.sh
echo "cp -rvf SampleCode $GAIA_THIRD_PARTY_HOME/triton-$TRITON_INSTALL_TARGET_VERSION" >> exec.sh
echo "cp -rvf third* /$GAIA_THIRD_PARTY_HOME/triton-$TRITON_INSTALL_TARGET_VERSION" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tInstallation de Triton $TRITON_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - Triton $TRITON_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
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
