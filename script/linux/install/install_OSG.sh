#!/bin/bash

# get current directory
current_dir=$PWD

# source user configured versions 
source user-config.versions.sh

# go to dir
cd /home/$(whoami)
mkdir osginst
cd osginst

echo; echo "## BEGIN"; echo

echo "########################################################"
echo "  NVTT : Decompression du/des package(s)"
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "tar -xzvf /data/CentOS_6.3/archive/nvidia-texture-tools-$NVTT_INSTALL_TARGET_VERSION.tar.gz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tDecompression de nvidia-texture tools $NVTT_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
echo "OK"

echo "########################################################"
echo "  NVTT : Configure, build & install"
echo "########################################################"

cd nvidia-texture-tools

echo "#!/bin/bash" > exec.sh
echo "./configure --prefix=/home/$(whoami)/Progiciels/nvtt-$NVTT_INSTALL_TARGET_VERSION" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tConfiguration de nvidia-texture tools $NVTT_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
echo "OK"

cp -f /data/CentOS_6.3/conf/nvidia-texture-tools/src/nvcore/Debug.cpp ./src/nvcore/

echo "#!/bin/bash" > exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCompilation de nvidia-texture tools $NVTT_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tInstallation de nvidia-texture tools $NVTT_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
echo "OK"

echo "########################################################"
echo "  OSG : Decompression du/des package(s)"
echo "########################################################"

cd ..

echo "#!/bin/bash" > exec.sh
echo "unzip /data/CentOS_6.3/archive/OpenSceneGraph-$OSG_INSTALL_TARGET_VERSION.zip" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tDecompression de OpenSceneGraph $OSG_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
echo "OK"

echo "########################################################"
echo "  OSG :CMake, build  & install"
echo "########################################################"

cd OpenSceneGraph-*

echo "#!/bin/bash" > exec.sh
echo "export NVTT_DIR=/home/$(whoami)/Progiciels/nvtt-$NVTT_INSTALL_TARGET_VERSION/" >> exec.sh
echo "cmake -DCMAKE_INSTALL_PREFIX=/home/$(whoami)/Progiciels/osg-$OSG_INSTALL_TARGET_VERSION ." >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tConfiguration de OpenSceneGraph $OSG_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCompilation de OpenSceneGraph $OSG_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tInstallation de OpenSceneGraph $OSG_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
echo "OK"

echo "########################################################"
echo "  Suppression du repertoire temporaire"
cd $current_dir
rm -rf /home/$(whoami)/osginst
echo "########################################################"

echo; echo "## END"; echo

