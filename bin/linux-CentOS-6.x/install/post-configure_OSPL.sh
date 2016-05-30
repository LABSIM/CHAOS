#!/bin/bash

# get current directory
current_dir=$PWD

# source user configured versions 
source user-config-versions.sh

# go to dir
cd /home/$(whoami)/Progiciels/opensplicedds-$OSPL_INSTALL_TARGET_VERSION/HDE/x86_64.linux/custom_lib

echo; echo "## BEGIN"; echo

echo "########################################################"
echo "  Vortex OpenSpliceDDS : re-build c++14 support"
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "make -e CCFLAGS+=\"-DOSPL_USE_CXX11 -std=c++14\"" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tRe-build d'OpenSpliceDDS $OSPL_INSTALL_TARGET_VERSION IsoCpp(std API) & Sacpp(streaming API) avec support du c++14 ..."
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
echo "OK"

cd $current_dir

echo; echo "## END"; echo



