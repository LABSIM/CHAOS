#!/bin/bash

echo

# get current directory
current_dir=$PWD

source ../../../conf/versions.sh
cd /home/$(whoami)
mkdir glfwinst
cd glfwinst

echo "########################################################"
echo "#!/bin/bash" > exec.sh
echo "tar -xvzf /data/CentOS_6.3/archive/glfw-legacy-$GLFW_VERSION.tar.gz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n "Decompression de GLFW $GLFW_VERSION ..."
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
echo "OK"

cd glfw-legacy-$GLFW_VERSION

echo "########################################################"
echo "#!/bin/bash" > exec.sh
echo "export PREFIX=/home/$(whoami)/Progiciels/glfw-$GLFW_VERSION" >> exec.sh
echo "make x11-dist-install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n "Conpilation de GLFW $GLFW_VERSION ..."
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
echo "OK"

echo "########################################################"
echo -n "Suppression du repertoire temporaire ... "
cd $current_dir
rm -rf /home/$(whoami)/glfwinst
echo "OK"

echo "########################################################"
echo
