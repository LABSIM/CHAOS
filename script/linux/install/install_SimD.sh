#!/bin/bash

echo

# get current directory
current_dir=$PWD

source ../../../conf/versions.sh
cd /home/$(whoami)
mkdir simdinst
cd simdinst

echo "########################################################"
echo "#!/bin/bash" > exec.sh
echo "tar -xvzf /data/CentOS_6.3/archive/simd-cxx-src-v$SIMD_MAJ_VER.$SIMD_MIN_VER.tar.gz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n "Decompression de SimpleDDS-$SIMD_VERSION ..."
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"

cd simd-cxx
mkdir build
cd build

echo "########################################################"
echo "#!/bin/bash" > exec.sh
echo "cmake -DCMAKE_INSTALL_PREFIX=/home/$(whoami)/Progiciels/SimD-$SIMD_VERSION -DCMAKE_BUILD_TYPE=Release -DINSTALL_DOC=/home/$(whoami)/Progiciels/SimD-$SIMD_VERSION .." >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n "Configuration de SimpleDDS-$SIMD_VERSION ..."
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"

echo "########################################################"
echo "#!/bin/bash" > exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n "Build & Install de SimpleDDS ..."
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"

echo "########################################################"
echo -n "Suppression du repertoire temporaire ... "
cd $current_dir
rm -rf /home/$(whoami)/simdinst
echo "OK"

echo "########################################################"
echo
