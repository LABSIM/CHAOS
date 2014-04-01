#!/bin/bash

echo

# get current directory
current_dir=$PWD

source ../../conf/versions.sh
cd /home/$(whoami)
mkdir taoinst
cd taoinst

echo "########################################################"
echo "#!/bin/bash" > exec.sh
echo "tar -xvf /data/CentOS_6.3/archive/TAO$TAO_MAJ_VER$TAO_MIN_VER$TAO_REV_VER-Linux-gcc412-inline-64bit-091104.tar" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n "Decompression de OpenFusionTAO $TAO_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"

echo "########################################################"
echo "#!/bin/bash" > exec.sh
echo "./install.sh /home/$(whoami)/Progiciels/OpenFusionTAO-$TAO_VERSION" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n "Installation de OpenFusionTAO ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"

echo "########################################################"
echo -n "Suppression du repertoire temporaire ... "
cd $current_dir
rm -rf /home/$(whoami)/taoinst
echo "OK"

echo "########################################################"
echo
