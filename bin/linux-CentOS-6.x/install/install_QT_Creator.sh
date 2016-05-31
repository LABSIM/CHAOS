#!/bin/bash

# get current directory
current_dir=$PWD

# source user configured versions 
source user-config-versions.sh
source wait_for_PID.sh

# go to dir
cd /tmp_user/$(hostname)/$(whoami)
mkdir qtcreatortinst
cd qtcreatortinst

echo; echo "## BEGIN"; echo

echo "########################################################"
echo " QT Creator - Decompression du/des package(s)"
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "tar -xzvf /data/CentOS_6.x/archive/qt-creator-*-$QTCREATOR_INSTALL_TARGET_VERSION.tar.gz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tDecompression de QT Creator $QTCREATOR_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 1.0
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "########################################################"
echo " QT Creator - Configure, build & install"
echo "########################################################"

cd qt-creator-*

echo "#!/bin/bash" > exec.sh
echo "qmake -r" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh-stl
echo -ne "\tConfiguration de QT Creator $QTCREATOR_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 1.0
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCompilation de QT Creator $QTCREATOR_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 1.0
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make install INSTALL_ROOT=/home/$(whoami)/Progiciels/qt-creator-$QTCREATOR_INSTALL_TARGET_VERSION" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tInstallation de QT Creator $QTCREATOR_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 1.0
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "########################################################"
echo "  Suppression des repertoires temporaires... "
rm -rf /tmp_user/$(hostname)/$(whoami)qtcreatortinst
echo "########################################################"

echo; echo "## END"; echo
