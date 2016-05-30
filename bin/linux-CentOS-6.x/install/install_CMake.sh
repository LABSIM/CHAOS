#!/bin/bash

# get current directory
current_dir=$PWD

# source user configured versions 
source user-config-versions.sh

# go to dir
cd /home/$(whoami)
mkdir cmakeinst
cd cmakeinst

echo; echo "## BEGIN"; echo

echo "########################################################"
echo "  Decompression du/des package(s)"
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "tar -xzvf /data/CentOS_6.3/archive/cmake-$CMAKE_INSTALL_TARGET_VERSION.tar.gz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tDecompression de cmake $CMAKE_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
echo "OK"

echo "########################################################"
echo " Bootstrap, build & install"
echo "########################################################"

cd cmake-*

# Cmake install or not ?
if hash cmake 2>/dev/null; then
	# cmake exist
	echo "#!/bin/bash" > exec.sh
	echo "cmake -DCMAKE_INSTALL_PREFIX=/home/$(whoami)/Progiciels/cmake-$CMAKE_INSTALL_TARGET_VERSION ." >> exec.sh
	echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
	echo -ne "\tCMake de cmake $CMAKE_INSTALL_TARGET_VERSION (Inception !)... "
	chmod u+x exec.sh
	gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
	echo "OK"
else
	# no cmake builtin -> bootstrap
	echo "#!/bin/bash" > exec.sh
	echo "./bootstrap --prefix=/home/$(whoami)/Progiciels/cmake-$CMAKE_INSTALL_TARGET_VERSION --parallel=4" >> exec.sh
	echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
	echo -ne "\tBootstrap de cmake $CMAKE_INSTALL_TARGET_VERSION ... "
	chmod u+x exec.sh
	gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
	echo "OK"
fi

echo "#!/bin/bash" > exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCompilation de cmake $CMAKE_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tInstallation de cmake $CMAKE_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
echo "OK"

echo "########################################################"
echo " Import des propriétés LABSIM"
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "cp -r $current_dir/../../../conf/cmake/* /home/$(whoami)/Progiciels/cmake-$CMAKE_INSTALL_TARGET_VERSION/share/cmake-$CMAKE_INSTALL_TARGET_MAJ_VER.$CMAKE_INSTALL_TARGET_MIN_VER/Modules/" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCopie des Module CMake specifiques (COTIRE, FindOpenSpliceDDS, FindSimpleDDS, FindLabsim* & KRONOS-DDS spec.) ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
echo "OK"

echo "########################################################"
echo "  Suppression du repertoire temporaire"
cd $current_dir
rm -rf /home/$(whoami)/cmakeinst
echo "########################################################"

echo; echo "## END"; echo

