#!/bin/bash

# get current directory
current_dir=$PWD

# source user configured versions 
source user-config-versions.sh
source ../../../../script/linux/wait_for_PID.sh

# go to local dir
cd /tmp_user/$(hostname)/$(whoami)
mkdir cmakeinst
cd cmakeinst

echo; echo "## BEGIN"; echo

echo "########################################################"
echo "                        CMake                           "
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "tar -xzvf /data/CentOS_6.x/archive/cmake-$CMAKE_INSTALL_TARGET_VERSION.tar.gz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tDecompression de CMake $CMAKE_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - CMake $CMAKE_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

cd cmake-*

# Cmake install or not ?
if hash cmake 2>/dev/null; then
	# cmake exist
	echo "#!/bin/bash" > exec.sh
	echo "cmake -DCMAKE_INSTALL_PREFIX=/home/$(whoami)/Progiciels/cmake-$CMAKE_INSTALL_TARGET_VERSION ." >> exec.sh
	echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
	echo -ne "\tCMake de cmake $CMAKE_INSTALL_TARGET_VERSION (Inception !)... "
	chmod u+x exec.sh
	gnome-terminal --working-directory $PWD --title="LABSIM - CMake $CMAKE_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
	sleep 0.2
	PID=$(pgrep exec.sh)
	wait_for_PID $PID
	echo "OK"
else
	# no cmake builtin -> bootstrap
	echo "#!/bin/bash" > exec.sh
	echo "./bootstrap --prefix=/home/$(whoami)/Progiciels/cmake-$CMAKE_INSTALL_TARGET_VERSION --parallel=4" >> exec.sh
	echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
	echo -ne "\tBootstrap de cmake $CMAKE_INSTALL_TARGET_VERSION ... "
	chmod u+x exec.sh
	gnome-terminal --working-directory $PWD --title="LABSIM - CMake $CMAKE_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
	sleep 0.2
	PID=$(pgrep exec.sh)
	wait_for_PID $PID
	echo "OK"
fi

echo "#!/bin/bash" > exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCompilation de cmake $CMAKE_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - CMake $CMAKE_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tInstallation de cmake $CMAKE_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - CMake $CMAKE_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "cp -r $current_dir/../../../../conf/cmake/* /home/$(whoami)/Progiciels/cmake-$CMAKE_INSTALL_TARGET_VERSION/share/cmake-$CMAKE_INSTALL_TARGET_MAJ_VER.$CMAKE_INSTALL_TARGET_MIN_VER/Modules/" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCopie des Module CMake specifiques (COTIRE, FindOpenSpliceDDS, FindSimpleDDS, FindLabsim* & KRONOS-DDS spec.) ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - CMake $CMAKE_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "########################################################"
echo "  Suppression du repertoire temporaire"
cd $current_dir
rm -rf /tmp_user/$(hostname)/$(whoami)/cmakeinst
echo "########################################################"

echo; echo "## END"; echo

