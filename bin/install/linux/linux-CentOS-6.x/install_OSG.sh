#!/bin/bash

# get current directory
current_dir=$PWD

# source user configured versions 
source user-config-versions.sh
source ../../../../script/linux/wait_for_PID.sh

# go to local dir
cd /tmp_user/$(hostname)/$(whoami)
mkdir osginst
cd osginst

echo; echo "## BEGIN"; echo

echo "########################################################"
echo "  OSG : Decompression du/des package(s)"
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "unzip /data/CentOS_6.x/archive/OpenSceneGraph-$OSG_INSTALL_TARGET_VERSION.zip" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tDecompression de OpenSceneGraph $OSG_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - OpenSceneGraph $OSG_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "########################################################"
echo "  OSG : CMake, build  & install"
echo "########################################################"

cd OpenSceneGraph-*

echo "#!/bin/bash" > exec.sh
echo "cmake -DCMAKE_INSTALL_PREFIX=/home/$(whoami)/Progiciels/osg-$OSG_INSTALL_TARGET_VERSION -DOPENGL_PROFILE=GL3 -DOSG_GL3_AVAILABLE=ON -DOSG_USE_FLOAT_BOUNDINGBOX=OFF -DOSG_USE_FLOAT_BOUNDINGSPHERE=OFF -DOSG_USE_FLOAT_MATRIX=OFF -DOSG_USE_FLOAT_PLANE=OFF ." >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tConfiguration de OpenSceneGraph $OSG_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - OpenSceneGraph $OSG_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCompilation de OpenSceneGraph $OSG_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - OpenSceneGraph $OSG_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tInstallation de OpenSceneGraph $OSG_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - OpenSceneGraph $OSG_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "########################################################"
echo "  Suppression du repertoire temporaire"
cd $current_dir
rm -rf /tmp_user/$(hostname)/$(whoami)/osginst
echo "########################################################"

echo; echo "## END"; echo

