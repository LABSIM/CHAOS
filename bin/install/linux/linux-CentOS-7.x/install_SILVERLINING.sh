#!/bin/bash

# get current directory
current_dir=$PWD

# source user configured versions 
source user-config-versions.sh
source ../../../../script/linux/wait_for_PID.sh

# go to dir
cd /home/$(whoami)
mkdir silverlininginst
cd silverlininginst

echo; echo "## BEGIN"; echo

echo "########################################################"
echo "  SilverLining : Decompression du/des package(s)"
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "tar -xvf /data/CentOS_7.x/sundog/SilverLining-SDK-FullSource.tgz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tDecompression du SDK SilverLining $SILVERLINING_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "########################################################"
echo "  SilverLining : Build & install"
echo "########################################################"

cd SilverLining-SDK-FullSource

echo "#!/bin/bash" > exec.sh
echo "make" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tBuild du SDK SilverLining $SILVERLINING_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "mkdir /home/$(whoami)/Progiciels/silverlining-$SILVERLINING_INSTALL_TARGET_VERSION" >> exec.sh
echo "cp -rf /home/$(whoami)/silverlininginst/SilverLining-SDK-FullSource/* /home/$(whoami)/Progiciels/silverlining-$SILVERLINING_INSTALL_TARGET_VERSION" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tInstall du SDK SilverLining $SILVERLINING_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "########################################################"
echo "  Suppression du repertoire temporaire"
cd $current_dir
rm -rf /home/$(whoami)/silverlininginst
echo "########################################################"

echo; echo "## END"; echo
