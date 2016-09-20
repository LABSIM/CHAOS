#!/bin/bash

# get current directory
current_dir=$PWD

# source user configured versions 
source user-config-versions.sh
source ../../wait_for_PID.sh

# go to local dir
cd /tmp_user/$(hostname)/$(whoami)
mkdir osvrlibfunctionalityinst
cd osvrlibfunctionalityinst

echo; echo "## BEGIN"; echo

echo "########################################################"
echo "  git"
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "git clone --recursive https://github.com/OSVR/libfunctionality.git" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCloning de OSVR - lib functionality $OSVR_LIBFUNCTIONALITY_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "########################################################"
echo " cmake, build & install"
echo "########################################################"

cd libfunctionality-*

mkdir build
cd build

echo "#!/bin/bash" > exec.sh
echo "cmake -DCMAKE_INSTALL_PREFIX=/home/$(whoami)/Progiciels/osvr-libfunctionality-$OSVR_LIBFUNCTIONALITY_INSTALL_TARGET_VERSION -DCMAKE_BUILD_TYPE=Release .." >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCMake de OSVR - lib functionality $OSVR_LIBFUNCTIONALITY_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCompilation de OSVR - lib functionality $OSVR_LIBFUNCTIONALITY_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tInstallation de OSVR - lib functionality $OSVR_LIBFUNCTIONALITY_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "########################################################"
echo "  Suppression du repertoire temporaire"
cd $current_dir
rm -rf /tmp_user/$(hostname)/$(whoami)/osvrlibfunctionalityinst
echo "########################################################"

echo; echo "## END"; echo

