#!/bin/bash

# get current directory
current_dir=$PWD

# source user configured versions 
source user-config-versions.sh
source ../../wait_for_PID.sh

# go to local dir
cd /tmp_user/$(hostname)/$(whoami)
mkdir vrpninst
cd vrpninst

echo; echo "## BEGIN"; echo

echo "########################################################"
echo "  git "
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "git clone https://github.com/vrpn/vrpn.git" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCloning de VRPN $VRPN_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "########################################################"
echo " cmake, build & install"
echo "########################################################"

cd vrpn

mkdir build
cd build

echo "#!/bin/bash" > exec.sh
echo "cmake -DCMAKE_INSTALL_PREFIX=/home/$(whoami)/Progiciels/vrpn-$VRPN_INSTALL_TARGET_VERSION -DCMAKE_BUILD_TYPE=Release -DVRPN_BUILD_JAVA=OFF -DVRPN_BUILD_PYTHON=OFF -DVRPN_BUILD_PYTHON_HANDCODED_2X=OFF -DVRPN_BUILD_PYTHON_HANDCODED_3X=OFF -DVRPN_USE_HID=ON -DVRPN_USE_LIBUSB_1_0=ON -DHIDAPI_INCLUDE_DIR=$HIDAPI_INCLUDEDIR/hidapi -DHIDAPI_LIBRARY=$HIDAPI_LIBRARYDIR/libhidapi-libusb.so .." >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCMake de VRPN $VRPN_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCompilation de VRPN $VRPN_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tInstallation de VRPN $VRPN_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "########################################################"
echo "  Suppression du repertoire temporaire"
cd $current_dir
rm -rf /tmp_user/$(hostname)/$(whoami)/vrpninst
echo "########################################################"

echo; echo "## END"; echo

