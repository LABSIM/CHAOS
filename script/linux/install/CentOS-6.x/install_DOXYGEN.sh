#!/bin/bash

# get current directory
current_dir=$PWD

# source user configured versions 
source user-config-versions.sh
source ../../wait_for_PID.sh

# go to local dir
cd /tmp_user/$(hostname)/$(whoami)
mkdir doxygeninst
cd doxygeninst

echo; echo "## BEGIN"; echo

echo "########################################################"
echo "                        Doxygen                         "
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "tar -xzvf /data/CentOS_6.x/archive/doxygen-$DOXYGEN_INSTALL_TARGET_VERSION.src.tar.gz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tDecompression de Doxygen $DOXYGEN_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - Doxygen $DOXYGEN_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

cd doxygen-*

echo "#!/bin/bash" > exec.sh
echo "cmake -DCMAKE_INSTALL_PREFIX=/home/$(whoami)/Progiciels/doxygen-$DOXYGEN_INSTALL_TARGET_VERSION -Dbuild_wizard=ON ." >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tConfiguration de Doxygen $DOXYGEN_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - Doxygen $DOXYGEN_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCompilation de Doxygen $DOXYGEN_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - Doxygen $DOXYGEN_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tInstallation de Doxygen $DOXYGEN_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - Doxygen $DOXYGEN_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "########################################################"
echo "  Suppression du repertoire temporaire"
cd $current_dir
rm -rf /tmp_user/$(hostname)/$(whoami)/doxygeninst
echo "########################################################"

echo; echo "## END"; echo

