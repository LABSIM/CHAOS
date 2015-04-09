#!/bin/bash

# get current directory
current_dir=$PWD

# source user configured versions 
source user-config-versions.sh

# go to dir
cd /home/$(whoami)
mkdir simdinst
cd simdinst

echo; echo "## BEGIN"; echo

echo "########################################################"
echo "  Decompression du/des package(s)"
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "unzip /data/CentOS_6.3/archive/simd-cxx-master.zip" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tDecompression de SimpleDDS-$SIMD_INSTALL_TARGET_VERSION ..."
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
echo "OK"

cd simd-cxx-master
mkdir build
cd build

echo "########################################################"
echo "  Cmake, build & install"
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=/home/$(whoami)/Progiciels/simd-$SIMD_INSTALL_TARGET_VERSION -DCMAKE_BUILD_TYPE=Release -DINSTALL_DOC=/home/$(whoami)/Progiciels/simd-$SIMD_INSTALL_TARGET_VERSION .." >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tConfiguration de SimpleDDS-$SIMD_INSTALL_TARGET_VERSION ..."
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tBuild & Install de SimpleDDS ..."
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
echo "OK"

echo "########################################################"
echo "  Suppression du repertoire temporaire "
cd $current_dir
rm -rf /home/$(whoami)/simdinst
echo "########################################################"

echo; echo "## END"; echo

