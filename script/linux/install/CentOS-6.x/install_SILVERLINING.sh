#!/bin/bash

# get current directory
current_dir=$PWD

# source user configured versions 
source user-config-versions.sh
source ../../wait_for_PID.sh

# go to local dir
cd /tmp_user/$(hostname)/$(whoami)
mkdir silverlininginst
cd silverlininginst

echo; echo "## BEGIN"; echo

echo "########################################################"
echo "                  Sundog SilverLining                   "  
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "tar -xvf /data/CentOS_6.x/sundog/SilverLining-SDK-FullSource.tgz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tDecompression de Silverlining $SILVERLINING_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - SilverLining $SILVERLINING_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

cd SilverLining-SDK-FullSource

echo "#!/bin/bash" > exec.sh
echo "make" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tBuild de Silverlining $SILVERLINING_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - SilverLining $SILVERLINING_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "mkdir /home/$(whoami)/Progiciels/silverlining-$SILVERLINING_INSTALL_TARGET_VERSION" >> exec.sh
echo "cp -rf /tmp_user/$(hostname)/$(whoami)/silverlininginst/SilverLining-SDK-FullSource/Docs /home/$(whoami)/Progiciels/silverlining-$SILVERLINING_INSTALL_TARGET_VERSION" >> exec.sh
echo "cp -rf /tmp_user/$(hostname)/$(whoami)/silverlininginst/SilverLining-SDK-FullSource/lib /home/$(whoami)/Progiciels/silverlining-$SILVERLINING_INSTALL_TARGET_VERSION" >> exec.sh
echo "cp -rf /tmp_user/$(hostname)/$(whoami)/silverlininginst/SilverLining-SDK-FullSource/Public* /home/$(whoami)/Progiciels/silverlining-$SILVERLINING_INSTALL_TARGET_VERSION" >> exec.sh
echo "cp -rf /tmp_user/$(hostname)/$(whoami)/silverlininginst/SilverLining-SDK-FullSource/Resources /home/$(whoami)/Progiciels/silverlining-$SILVERLINING_INSTALL_TARGET_VERSION" >> exec.sh
echo "cp -rf /tmp_user/$(hostname)/$(whoami)/silverlininginst/SilverLining-SDK-FullSource/SampleCode /home/$(whoami)/Progiciels/silverlining-$SILVERLINING_INSTALL_TARGET_VERSION" >> exec.sh
echo "cp -rf /tmp_user/$(hostname)/$(whoami)/silverlininginst/SilverLining-SDK-FullSource/third* /home/$(whoami)/Progiciels/silverlining-$SILVERLINING_INSTALL_TARGET_VERSION" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tInstallation de Silverlining $SILVERLINING_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - SilverLining $SILVERLINING_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "########################################################"
echo "  Suppression du repertoire temporaire"
cd $current_dir
rm -rf /tmp_user/$(hostname)/$(whoami)/silverlininginst
echo "########################################################"

echo; echo "## END"; echo
