#!/bin/bash

# get current directory
current_dir=$PWD

# source user configured versions 
source user-config.versions.sh

# go to dir
cd /home/$(whoami)
mkdir taoinst
cd taoinst

echo; echo "## BEGIN"; echo

echo "########################################################"
echo "  Decompression du/des package(s)"
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "tar -xvf /data/CentOS_6.3/archive/TAO$TAO_INSTALL_TARGET_MAJ_VER$TAO_INSTALL_TARGET_MIN_VER$TAO_INSTALL_TARGET_PATCH_VER-Linux-gcc412-inline-64bit-091104.tar" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tDecompression de OpenFusionTAO $TAO_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
echo "OK"

echo "########################################################"
echo "  Install"
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "./install.sh /home/$(whoami)/Progiciels/openfusiontao-$TAO_INSTALL_TARGET_VERSION" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tInstallation de OpenFusionTAO $TAO_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
echo "OK"

echo "########################################################"
echo "  Suppression du repertoire temporaire"
cd $current_dir
rm -rf /home/$(whoami)/taoinst
echo "########################################################"

echo; echo "## END"; echo

