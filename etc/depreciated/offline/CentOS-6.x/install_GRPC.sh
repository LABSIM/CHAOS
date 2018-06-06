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

# go to local dir
cd /tmp_user/$(hostname)/$(whoami)
mkdir grpcinst
cd grpcinst

echo; echo "## BEGIN"; echo

echo "########################################################"
echo "                       gRPC & Protobuf"
echo "########################################################"

# ===============
# Main repository
# ===============

echo "#!/bin/bash" > exec.sh
echo "git clone --recursive -b $(curl -L http://grpc.io/release) https://github.com/grpc/grpc" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCloning de gRPC $GRPC_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - gRPC $GRPC_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

cd grpc*/third_party/protobuf

	# ========
	# Protobuf
	# ========

	echo "#!/bin/bash" > exec.sh
	echo "./autogen.sh" >> exec.sh
	echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
	echo -ne "\tGeneration du fichier de configuration pour Protobuf $PROTOBUF_INSTALL_TARGET_VERSION ... "
	chmod u+x exec.sh
	gnome-terminal --working-directory $PWD --title="LABSIM - Protobuf $PROTOBUF_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
	sleep 0.2
	PID=$(pgrep exec.sh)
	wait_for_PID $PID
	echo "OK"

	echo "#!/bin/bash" > exec.sh
	echo "./configure --prefix=/home/$(whoami)/Progiciels/protobuf-$PROTOBUF_INSTALL_TARGET_VERSION" >> exec.sh
	echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
	echo -ne "\tConfiguration de Protobuf $PROTOBUF_INSTALL_TARGET_VERSION ... "
	chmod u+x exec.sh
	gnome-terminal --working-directory $PWD --title="LABSIM - Protobuf $PROTOBUF_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
	sleep 0.2
	PID=$(pgrep exec.sh)
	wait_for_PID $PID
	echo "OK"

	echo "#!/bin/bash" > exec.sh
	echo "make -j4" >> exec.sh
	echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
	echo -ne "\tBuild de Protobuf $PROTOBUF_INSTALL_TARGET_VERSION ... "
	chmod u+x exec.sh
	gnome-terminal --working-directory $PWD --title="LABSIM - Protobuf $PROTOBUF_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
	sleep 0.2
	PID=$(pgrep exec.sh)
	wait_for_PID $PID
	echo "OK"

	echo "#!/bin/bash" > exec.sh
	echo "make check" >> exec.sh
	echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
	echo -ne "\tChecking de Protobuf $PROTOBUF_INSTALL_TARGET_VERSION ... "
	chmod u+x exec.sh
	gnome-terminal --working-directory $PWD --title="LABSIM - Protobuf $PROTOBUF_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
	sleep 0.2
	PID=$(pgrep exec.sh)
	wait_for_PID $PID
	echo "OK"

	echo "#!/bin/bash" > exec.sh
	echo "make install" >> exec.sh
	echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
	echo -ne "\tInstall de Protobuf $PROTOBUF_INSTALL_TARGET_VERSION ... "
	chmod u+x exec.sh
	gnome-terminal --working-directory $PWD --title="LABSIM - Protobuf $PROTOBUF_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
	sleep 0.2
	PID=$(pgrep exec.sh)
	wait_for_PID $PID
	echo "OK"

	echo "#!/bin/bash" > exec.sh
	echo "sudo /sbin/ldconfig" >> exec.sh
	echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
	echo -ne "\tMise a jour du cache de /usr/bin/ld pour Protobuf $PROTOBUF_INSTALL_TARGET_VERSION ... "
	chmod u+x exec.sh
	gnome-terminal --working-directory $PWD --title="LABSIM - Protobuf $PROTOBUF_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
	sleep 0.2
	PID=$(pgrep exec.sh)
	wait_for_PID $PID
	echo "OK"

cd ../..

# ====
# gRPC
# ====

echo "#!/bin/bash" > exec.sh
echo "make -j4 install prefix=/home/$(whoami)/Progiciels/grpc-$GRPC_INSTALL_TARGET_VERSION" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tInstallation de gRPC $GRPC_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - gRPC $GRPC_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"


echo "#!/bin/bash" > exec.sh
echo "sudo /sbin/ldconfig" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tMise a jour du cache de /usr/bin/ld pour gRPC $GRPC_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - gRPC $GRPC_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "########################################################"
echo "  Suppression du repertoire temporaire"
cd $current_dir
rm -rf /tmp_user/$(hostname)/$(whoami)/grpcinst
echo "########################################################"

echo; echo "## END"; echo
