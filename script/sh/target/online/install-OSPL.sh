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
#if [ -d "$BUILD_DIR" ]; then 
#	rm -rf $BUILD_DIR
#fi
mkdir --parents $BUILD_DIR
cd $BUILD_DIR

echo; echo "## BEGIN"; echo

echo "########################################################"
echo "                   Vortex OpenSplice                    "
echo "########################################################"

#	echo "#!/bin/bash" > exec.sh
#	echo "wget https://vorboss.dl.sourceforge.net/project/gsoap$GSOAP_INSTALL_TARGET_MAJ_VER/gsoap-$GSOAP_INSTALL_TARGET_MAJ_VER.$GSOAP_INSTALL_TARGET_MIN_VER/gsoap_$GSOAP_INSTALL_TARGET_VERSION.zip" >> exec.sh
#	echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
#	echo -ne "\tTelechargement de gSOAP $GSOAP_INSTALL_TARGET_VERSION (OpenSplice requirement) ... "
#	chmod u+x exec.sh
#	gnome-terminal --working-directory $PWD --title="LABSIM - gSOAP $GSOAP_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
#	sleep 0.2
#	PID=$(pgrep exec.sh)
#	wait_for_PID $PID
#	echo "OK"
#
#	echo "#!/bin/bash" > exec.sh
#	echo "unzip gsoap_$GSOAP_INSTALL_TARGET_VERSION.zip" >> exec.sh
#	echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
#	echo -ne "\tDecompression de gSOAP $GSOAP_INSTALL_TARGET_VERSION (OpenSplice requirement) ... "
#	chmod u+x exec.sh
#	gnome-terminal --working-directory $PWD --title="LABSIM - gSOAP $GSOAP_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
#	sleep 0.2
#	PID=$(pgrep exec.sh)
#	wait_for_PID $PID
#	echo "OK"
#
#	cd gsoap-*
#	mkdir build
#	cd build
#
#	echo "#!/bin/bash" > exec.sh
#	echo "../configure --prefix=$GAIA_THIRD_PARTY_HOME/gsoap-$GSOAP_INSTALL_TARGET_VERSION" >> exec.sh
#	echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
#	echo -ne "\tConfiguration de gSOAP $GSOAP_INSTALL_TARGET_VERSION (OpenSplice requirement)... "
#	chmod u+x exec.sh
#	gnome-terminal --working-directory $PWD --title="LABSIM - gSOAP $GSOAP_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
#	sleep 0.2
#	PID=$(pgrep exec.sh)
#	wait_for_PID $PID
#	echo -e "\t==> OK"
#
#	echo "#!/bin/bash" > exec.sh
#	echo "make" >> exec.sh
#	echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
#	echo -ne "\tCompilation de gSOAP $GSOAP_INSTALL_TARGET_VERSION (OpenSplice requirement)... "
#	chmod u+x exec.sh
#	gnome-terminal --working-directory $PWD --title="LABSIM - gSOAP $GSOAP_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
#	sleep 0.2
#	PID=$(pgrep exec.sh)
#	wait_for_PID $PID
#	echo -e "\t==> OK"
#
#	echo "#!/bin/bash" > exec.sh
#	echo "make install" >> exec.sh
#	echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
#	echo -ne "\tInstall de gSOAP $GSOAP_INSTALL_TARGET_VERSION (OpenSplice requirement)... "
#	chmod u+x exec.sh
#	gnome-terminal --working-directory $PWD --title="LABSIM - gSOAP $GSOAP_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
#	sleep 0.2
#	PID=$(pgrep exec.sh)
#	wait_for_PID $PID
#	echo -e "\t==> OK"

#cd ../..

echo "#!/bin/bash" > exec.sh
echo "git clone https://github.com/ADLINK-IST/opensplice.git" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCloning d'OpenSplice $OSPL_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - OpenSplice $OSPL_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

cd opensplice/

echo "#!/bin/bash" > exec.sh
echo "git checkout --force tags/OSPL_V$OSPL_INSTALL_TARGET_MAJ_VER\_$OSPL_INSTALL_TARGET_MIN_VER\_$OSPL_INSTALL_TARGET_PATCH_VER\OSS_RELEASE" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCheckout release tag d'OpenSplice $OSPL_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - OpenSplice $OSPL_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

cd submods/

echo "#!/bin/bash" > exec.sh
echo "git clone --recursive https://github.com/ADLINK-IST/MPC_ROOT.git" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCloning de submods/MPC_ROOT pour OpenSplice $OSPL_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - OpenSplice $OSPL_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

cd ..

echo "#!/bin/bash" > exec.sh
echo "sed -i 's/soapcpp2 -v 2> soapcpp2.ver/# fuck that :) --> soapcpp2 -v 2> soapcpp2.ver/g' bin/checkconf" >> exec.sh
echo "sed -i 's/GSOAP_VERSION=/GSOAP_VERSION=$(soapcpp2 -V)\n\t# fuck that :) --> /g' bin/checkconf" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCorrection d'une macro de configuration d'OpenSplice $OSPL_INSTALL_TARGET_VERSION ..."
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - OpenSplice $OSPL_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "export OSPL_QT_IS_ON=no && export OSPL_HOME=$GAIA_THIRD_PARTY_HOME/opensplice-$OSPL_INSTALL_TARGET_VERSION && export GSOAPHOME=$GAIA_THIRD_PARTY_HOME/gsoap-$GSOAP_INSTALL_TARGET_VERSION && source ./configure x86_64.linux-release" >> exec.sh
#echo "export OSPL_QT_IS_ON=no && export OSPL_HOME=$GAIA_THIRD_PARTY_HOME/opensplice-$OSPL_INSTALL_TARGET_VERSION && source ./configure x86_64.linux-release" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tConfiguration d'OpenSplice $OSPL_INSTALL_TARGET_VERSION ..."
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - OpenSplice $OSPL_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "source envs-x86_64.linux-release.sh && make" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tBuild d'OpenSplice $OSPL_INSTALL_TARGET_VERSION..."
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - OpenSplice $OSPL_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

#echo "#!/bin/bash" > exec.sh
#echo "mkdir /home/$(whoami)/Progiciels/opensplicedds-$OSPL_INSTALL_TARGET_VERSION" >> exec.sh
#echo "mkdir /home/$(whoami)/Progiciels/opensplicedds-$OSPL_INSTALL_TARGET_VERSION/log " >> exec.sh
#echo "mkdir /home/$(whoami)/Progiciels/opensplicedds-$OSPL_INSTALL_TARGET_VERSION/store " >> exec.sh
#echo "mkdir /home/$(whoami)/Progiciels/opensplicedds-$OSPL_INSTALL_TARGET_VERSION/config " >> exec.sh
#echo "cp -r install/HDE /home/$(whoami)/Progiciels/opensplicedds-$OSPL_INSTALL_TARGET_VERSION" >> exec.sh
#echo "cp -r install/RTS /home/$(whoami)/Progiciels/opensplicedds-$OSPL_INSTALL_TARGET_VERSION" >> exec.sh
#echo "cp -r install/VC /home/$(whoami)/Progiciels/opensplicedds-$OSPL_INSTALL_TARGET_VERSION" >> exec.sh
#echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
#echo -ne "\tCopie des environments d'OpenSpliceDDS et creation des directories Progiciels..."
#chmod u+x exec.sh
#gnome-terminal --working-directory $PWD --title="LABSIM - Vortex OpenSpliceDDS $OSPL_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
#sleep 0.2
#PID=$(pgrep exec.sh)
#wait_for_PID $PID

cd HDE/x86_64.linux/custom_lib

echo "#!/bin/bash" > exec.sh
echo "sed -i 's/CPPFLAGS      = /CPPFLAGS      = -DOSPL_USE_CXX11 -std=c++14 /g' Makefile.Build_DCPS_ISO_Cpp_Lib" >> exec.sh
echo "sed -i 's/CPPFLAGS      = /CPPFLAGS      = -DOSPL_USE_CXX11 -std=c++14 /g' Makefile.Build_DCPS_ISO_Cpp2_Lib" >> exec.sh
echo "source ../../envs-x86_64.linux-release.sh && make -j6" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tRe-build de la couche ISOCPP v1.0 & v2.0 - DCPS - d'OpenSplice $OSPL_INSTALL_TARGET_VERSION avec le support explicite du c++14 ..."
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - Vortex OpenSplice $OSPL_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

cd ../../..

echo "#!/bin/bash" > exec.sh
echo "source envs-x86_64.linux-release.sh && make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tInstall OpenSplice $OSPL_INSTALL_TARGET_VERSION..."
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - OpenSplice $OSPL_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo -ne "\tConfiguration de l'environment d'OpenSplice..."
sed -i "s|@@INSTALLDIR@@|$GAIA_THIRD_PARTY_HOME/opensplice-$OSPL_INSTALL_TARGET_VERSION|g" $GAIA_THIRD_PARTY_HOME/opensplice-$OSPL_INSTALL_TARGET_VERSION/HDE/x86_64.linux/release.com
sed -i "s|@@INSTALLDIR@@|$GAIA_THIRD_PARTY_HOME/opensplice-$OSPL_INSTALL_TARGET_VERSION|g" $GAIA_THIRD_PARTY_HOME/opensplice-$OSPL_INSTALL_TARGET_VERSION/RTS/x86_64.linux/release.com
echo "OK"

rm -f exec.sh

echo "########################################################"
echo -ne "\tSuppression du repertoire temporaire ..."
cd $CURRENT_DIR
rm -rf $BUILD_DIR
echo "OK"
echo "########################################################"

echo; echo "## END"; echo

