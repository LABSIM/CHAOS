#!/bin/bash

# get current directory
current_dir=$PWD

# source user configured versions 
source user-config-versions.sh
source ../../wait_for_PID.sh

# go to dir
cd /home/$(whoami)
mkdir osplinst
cd osplinst

echo; echo "## BEGIN"; echo

echo "########################################################"
echo "  Decompression du/des package(s)"
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "unzip /data/CentOS_7.x/archive/opensplice-master.zip" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tDecompression d'OpenSpliceDDS $OSPL_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

cd opensplice-master/submods/
rm -rf MPC_ROOT/

echo "#!/bin/bash" > exec.sh
echo "unzip /data/CentOS_6.3/archive/MPC_ROOT-master.zip && mv MPC_ROOT-master MPC_ROOT" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tDecompression de MPC_ROOT specifique pour OpenSpliceDDS $OSPL_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

cd ../

echo "########################################################"
echo "  Configure, build & install"
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "export OSPL_QT_IS_ON=no && ./configure x86_64.linux-release" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tConfiguration d'OpenSpliceDDS ..."
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo -ne "\tSourcing de la configuration d'OpenSpliceDDS ..."
source envs-x86_64.linux-release.sh
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tBuild & Install OpenSpliceDDS $OSPL_INSTALL_TARGET_VERSION..."
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "mkdir /home/$(whoami)/Progiciels/opensplicedds-$OSPL_INSTALL_TARGET_VERSION" >> exec.sh
echo "mkdir /home/$(whoami)/Progiciels/opensplicedds-$OSPL_INSTALL_TARGET_VERSION/log " >> exec.sh
echo "mkdir /home/$(whoami)/Progiciels/opensplicedds-$OSPL_INSTALL_TARGET_VERSION/store " >> exec.sh
echo "mkdir /home/$(whoami)/Progiciels/opensplicedds-$OSPL_INSTALL_TARGET_VERSION/config " >> exec.sh
echo "cp -r install/HDE /home/$(whoami)/Progiciels/opensplicedds-$OSPL_INSTALL_TARGET_VERSION" >> exec.sh
echo "cp -r install/RTS /home/$(whoami)/Progiciels/opensplicedds-$OSPL_INSTALL_TARGET_VERSION" >> exec.sh
echo "cp -r install/VC /home/$(whoami)/Progiciels/opensplicedds-$OSPL_INSTALL_TARGET_VERSION" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCopie des environments d'OpenSpliceDDS et creation des directories Progiciels..."
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID

sed -i "s|@@INSTALLDIR@@|/home/$(whoami)/Progiciels/opensplicedds-$OSPL_INSTALL_TARGET_VERSION|g" /home/$(whoami)/Progiciels/opensplicedds-$OSPL_INSTALL_TARGET_VERSION/HDE/x86_64.linux/release.com
sed -i "s|@@INSTALLDIR@@|/home/$(whoami)/Progiciels/opensplicedds-$OSPL_INSTALL_TARGET_VERSION|g" /home/$(whoami)/Progiciels/opensplicedds-$OSPL_INSTALL_TARGET_VERSION/RTS/x86_64.linux/release.com

echo "OK"

cd /home/$(whoami)/Progiciels/opensplicedds-$OSPL_INSTALL_TARGET_VERSION/HDE/x86_64.linux/custom_lib

echo "#!/bin/bash" > exec.sh
echo "sed -i 's/CPPFLAGS      = /CPPFLAGS      = -DOSPL_USE_CXX11 -std=c++14 /g' Makefile.Build_DCPS_ISO_Cpp_Lib" >> exec.sh
echo "sed -i 's/CPPFLAGS      = /CPPFLAGS      = -DOSPL_USE_CXX11 -std=c++14 /g' Makefile.Build_DCPS_Stand_Alone_Cpp_Lib" >> exec.sh
echo "make" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tRe-build de la couche ISO CPP du DCPS d'OpenSpliceDDS $OSPL_INSTALL_TARGET_VERSION avec le support explicite du c++14 ..."
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

rm -f exec.sh

echo "########################################################"
echo "  Suppression du repertoire temporaire"
cd $current_dir
rm -rf /home/$(whoami)/osplinst
echo "########################################################"

echo; echo "## END"; echo

