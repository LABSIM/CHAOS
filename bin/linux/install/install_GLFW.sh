#!/bin/bash

# get current directory
current_dir=$PWD

# source user configured versions 
source user-config.versions.sh

# go to dir
cd /home/$(whoami)
mkdir glfwinst
cd glfwinst

echo; echo "## BEGIN"; echo

echo "########################################################"
echo "  Decompression du/des package(s)"
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "tar -xvzf /data/CentOS_6.3/archive/glfw-$GLFW_INSTALL_TARGET_VERSION.tar.gz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tDecompression de GLFW $GLFW_INSTALL_TARGET_VERSION ..."
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
echo "OK"

cd glfw-$GLFW_INSTALL_TARGET_VERSION

echo "########################################################"
echo "  Build & install"
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "export PREFIX=/home/$(whoami)/Progiciels/glfw-$GLFW_INSTALL_TARGET_VERSION" >> exec.sh
echo "make x11-dist-install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCompilation de GLFW $GLFW_INSTALL_TARGET_VERSION ..."
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
echo "OK"

echo "########################################################"
echo "  Suppression du repertoire temporaire"
cd $current_dir
rm -rf /home/$(whoami)/glfwinst
echo "########################################################"

echo; echo "## END"; echo

