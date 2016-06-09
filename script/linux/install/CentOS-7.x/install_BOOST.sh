#!/bin/bash

# get current directory
current_dir=$PWD

# source user configured versions 
source user-config-versions.sh
source ../../wait_for_PID.sh

# go to dir
cd /home/$(whoami)
mkdir boostinst
cd boostinst

echo; echo "## BEGIN"; echo

echo "########################################################"
echo "  Decompression du/des package(s)"
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "tar -xzvf /data/CentOS_7.x/archive/boost_$BOOST_INSTALL_TARGET_MAJ_VER\_$BOOST_INSTALL_TARGET_MIN_VER\_$BOOST_INSTALL_TARGET_PATCH_VER.tar.gz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tDecompression de boost $BOOST_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "########################################################"
echo " Bootstrap, build [bjam] & install"
echo "########################################################"

cd boost_*
echo "#!/bin/bash" > exec.sh
echo "./bootstrap.sh" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tConstruction du Boost.build engine ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "./b2 --prefix=/home/$(whoami)/Progiciels/boost-$BOOST_INSTALL_TARGET_VERSION toolset=gcc cxxflags="-std=c++11" variant=release link=shared threading=multi runtime-link=shared -j4 install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCompilation et installation de boost $BOOST_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "########################################################"
echo "  Suppression du repertoire temporaire"
cd $current_dir
rm -rf /home/$(whoami)/boostinst
echo "########################################################"

echo; echo "## END"; echo
