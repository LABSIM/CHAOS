#!/bin/bash

# get current directory
current_dir=$PWD

# source user configured versions 
source user-config-versions.sh

source wait_for_PID.sh

# go to dir
cd /home/$(whoami)
mkdir glfwinst
cd glfwinst

echo; echo "## BEGIN"; echo

echo "########################################################"
echo "  Decompression du/des package(s)"
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "unzip /data/CentOS_7.x/archive/glfw-$GLFW_INSTALL_TARGET_VERSION.zip" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tDecompression de GLFW $GLFW_INSTALL_TARGET_VERSION ..."
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
PID=`pgrep exec.sh`
wait_for_PID $PID
echo "OK"

cd glfw-$GLFW_INSTALL_TARGET_VERSION

echo "########################################################"
echo "  Build & install"
echo "########################################################"
BUILD_SHARED_LIBS

echo "#!/bin/bash" > exec.sh
echo "cmake . -Wno-dev -DCMAKE_INSTALL_PREFIX=/home/$(whoami)/Progiciels/glfw-$GLFW_INSTALL_TARGET_VERSION -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=TRUE -DGLFW_BUILD_EXAMPLES=FALSE -DGLFW_BUILD_TESTS=FALSE -DGLFW_BUILD_DOCS=FALSE" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tConfiguration de GLFW $GLFW_INSTALL_TARGET_VERSION ..."
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
PID=`pgrep exec.sh`
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make -j4 install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tBuild & Install de GLFW $GLFW_INSTALL_TARGET_VERSION ..."
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
PID=`pgrep exec.sh`
wait_for_PID $PID
echo "OK"

echo "########################################################"
echo "  Suppression du repertoire temporaire"
cd $current_dir
rm -rf /home/$(whoami)/glfwinst
echo "########################################################"

echo; echo "## END"; echo

