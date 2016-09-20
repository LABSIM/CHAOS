#!/bin/bash

# get current directory
current_dir=$PWD

# source user configured versions 
source user-config-versions.sh
source ../../wait_for_PID.sh

# go to local dir
cd /tmp_user/$(hostname)/$(whoami)
mkdir osvrcoreinst
cd osvrcoreinst

echo; echo "## BEGIN"; echo

echo "########################################################"
echo "  git "
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "git clone --recursive https://github.com/OSVR/OSVR-Core.git" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCloning de OSVR - core $OSVR_CORE_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "########################################################"
echo " cmake, build & install"
echo "########################################################"

cd OSVR-Core*

mkdir build
cd build

echo "#!/bin/bash" > exec.sh
echo "cmake -DCMAKE_INSTALL_PREFIX=/home/$(whoami)/Progiciels/osvr-core-$OSVR_CORE_INSTALL_TARGET_VERSION -DCMAKE_BUILD_TYPE=Release -DBoost_NO_BOOST_CMAKE=ON -Djsoncpp_DIR=$JSONCPP_LIBRARYDIR/cmake/jsoncpp -Dlibfunctionality_DIR=$OSVR_LIBFUNCTIONALITY_LIBRARYDIR/cmake/libfunctionality .." >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCMake de OSVR - core $OSVR_CORE_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCompilation de OSVR - core $OSVR_CORE_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tInstallation de OSVR - core $OSVR_CORE_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "########################################################"
echo "  Suppression du repertoire temporaire"
cd $current_dir
rm -rf /tmp_user/$(hostname)/$(whoami)/osvrcoreinst
echo "########################################################"

echo; echo "## END"; echo

