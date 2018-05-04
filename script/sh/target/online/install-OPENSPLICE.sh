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
BUILD_DIR=/tmp/GAIA/$(whoami)/build/opensplice

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
echo "                   Vortex OpenSplice                    "
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "git clone https://github.com/ADLINK-IST/opensplice.git" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCloning d'OpenSplice $OPENSPLICE_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - OpenSplice $OPENSPLICE_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

cd opensplice/

echo "#!/bin/bash" > exec.sh
echo "git checkout --force tags/OPENSPLICE_V$OPENSPLICE_INSTALL_TARGET_MAJ_VER\_$OPENSPLICE_INSTALL_TARGET_MIN_VER\_OSS_RELEASE" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCheckout release tag d'OpenSplice $OPENSPLICE_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - OpenSplice $OPENSPLICE_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

cd submods/

echo "#!/bin/bash" > exec.sh
echo "git clone --recursive https://github.com/ADLINK-IST/MPC_ROOT.git" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCloning de submods/MPC_ROOT pour OpenSplice $OPENSPLICE_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - OpenSplice $OPENSPLICE_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

cd ..

echo "#!/bin/bash" > exec.sh
echo "sed -i 's/soapcpp2 -v 2> soapcpp2.ver/# fuck this :) --> soapcpp2 -v 2> soapcpp2.ver/g' bin/checkconf" >> exec.sh
echo "sed -i 's/GSOAP_VERSION=/GSOAP_VERSION=$\(soapcpp2 -V\)\n\t# fuck that too :) --> /g' bin/checkconf" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCorrection d'une macro de configuration d'OpenSplice $OPENSPLICE_INSTALL_TARGET_VERSION ..."
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - OpenSplice $OPENSPLICE_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "export OPENSPLICE_QT_IS_ON=no && export GSOAPHOME=$GAIA_THIRD_PARTY_HOME/gsoap-$GSOAP_INSTALL_TARGET_VERSION && ./configure x86_64.linux-release" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tConfiguration d'OpenSplice $OPENSPLICE_INSTALL_TARGET_VERSION ..."
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - OpenSplice $OPENSPLICE_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "source envs-x86_64.linux-release.sh && export INCLUDE_SERVICES_CMSOAP=no && unset CFLAGS_LTO && make" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tBuild d'OpenSplice $OPENSPLICE_INSTALL_TARGET_VERSION..."
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - OpenSplice $OPENSPLICE_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "source envs-x86_64.linux-release.sh && export INCLUDE_SERVICES_CMSOAP=no && unset CFLAGS_LTO && make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tInstall local du Host Development Environment (HDE) OpenSplice $OPENSPLICE_INSTALL_TARGET_VERSION..."
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - OpenSplice $OPENSPLICE_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "mkdir $GAIA_THIRD_PARTY_HOME/opensplice-$OPENSPLICE_INSTALL_TARGET_VERSION && cp -rv install/HDE/x86_64.linux/* $GAIA_THIRD_PARTY_HOME/opensplice-$OPENSPLICE_INSTALL_TARGET_VERSION" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tInstall d'OpenSplice $OPENSPLICE_INSTALL_TARGET_VERSION..."
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - OpenSplice $OPENSPLICE_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

rm -f exec.sh

echo "########################################################"
echo -ne "\tSuppression du repertoire temporaire ..."
cd $CURRENT_DIR
rm -rf $BUILD_DIR
echo "OK"
echo "########################################################"

echo; echo "## END"; echo

