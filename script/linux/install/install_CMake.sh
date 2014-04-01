#!/bin/bash

echo 

# get current directory
current_dir=$PWD

source ../../../conf/versions.sh
cd /home/$(whoami)
mkdir cmakeinst
cd cmakeinst

echo "########################################################"
echo "#!/bin/bash" > exec.sh
echo "tar -xzvf /data/CentOS_6.3/archive/cmake-$CMAKE_VERSION.tar.gz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n "Decompression de cmake $CMAKE_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"

echo "########################################################"
cd cmake-$CMAKE_VERSION
echo "#!/bin/bash" > exec.sh
echo "./configure --prefix=/home/$(whoami)/Progiciels/cmake-$CMAKE_VERSION" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n "Configuration de cmake $CMAKE_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"

echo "########################################################"
echo "#!/bin/bash" > exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n "Compilation de cmake $CMAKE_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"

echo "########################################################"
echo "#!/bin/bash" > exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n "Installation de cmake $CMAKE_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"

echo "########################################################"
echo "#!/bin/bash" > exec.sh
echo "cp -r $current_dir/../../../conf/cmake/* /home/$(whoami)/Progiciels/cmake-$CMAKE_VERSION/share/cmake-$CMAKE_MAJ_VER.$CMAKE_MIN_VER/Modules/" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n "Copie des Module CMake specifiques (FindOpenSpliceDDS, FindSimpleDDS & KRONOS-DDS spec.)..."
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"

echo "########################################################"
echo -n "Suppression du repertoire temporaire ... "
cd $current_dir
rm -rf /home/$(whoami)/cmakeinst
echo "OK"
echo "########################################################"

echo
