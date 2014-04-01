#!/bin/bash

echo

# get current directory
current_dir=$PWD

source ../../../conf/versions.sh
cd /home/$(whoami)
mkdir osplinst
cd osplinst

echo "########################################################"
echo "#!/bin/bash" > exec.sh
echo "tar -xvzf /data/CentOS_6.3/archive/OpenSpliceDDSV$OSPL_VERSION-src.tar.gz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n "Decompression de OpenSpliceDDS $OSPL_VERSION ..."
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"

cd OpenSplice

echo "########################################################"
echo "#!/bin/bash" > exec.sh
echo "./configure" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n "Configuration de OpenSpliceDDS ..."
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"

echo "########################################################"
echo -n "Sourcing de la configuration d'OpenSpliceDDS ..."
source envs-*.sh
echo "OK"

echo "########################################################"
echo "#!/bin/bash" > exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n "Build & Install d'OpenSpliceDDS ..."
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"

echo "########################################################"
echo "#!/bin/bash" > exec.sh
echo "mkdir /home/$(whoami)/Progiciels/OpenSpliceDDS-$OSPL_VERSION" >> exec.sh
echo "mkdir /home/$(whoami)/Progiciels/OpenSpliceDDS-$OSPL_VERSION/log " >> exec.sh
echo "mkdir /home/$(whoami)/Progiciels/OpenSpliceDDS-$OSPL_VERSION/store " >> exec.sh
echo "mkdir /home/$(whoami)/Progiciels/OpenSpliceDDS-$OSPL_VERSION/config " >> exec.sh
echo "cp -r install/HDE /home/$(whoami)/Progiciels/OpenSpliceDDS-$OSPL_VERSION" >> exec.sh
echo "cp -r install/RTS /home/$(whoami)/Progiciels/OpenSpliceDDS-$OSPL_VERSION" >> exec.sh
echo "cp -r install/VC /home/$(whoami)/Progiciels/OpenSpliceDDS-$OSPL_VERSION" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n "Copie des environments d'OpenSpliceDDS et creation des directories Progiciels..."
chmod u+x exec.sh

gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"

sed -i "s|@@INSTALLDIR@@|/home/$(whoami)/Progiciels/OpenSpliceDDS-$OSPL_VERSION|g" /home/$(whoami)/Progiciels/OpenSpliceDDS-$OSPL_VERSION/HDE/x86_64.linux2.6/release.com
sed -i "s|@@INSTALLDIR@@|/home/$(whoami)/Progiciels/OpenSpliceDDS-$OSPL_VERSION|g" /home/$(whoami)/Progiciels/OpenSpliceDDS-$OSPL_VERSION/RTS/x86_64.linux2.6/release.com

echo "OK"

echo "########################################################"
echo -n "Suppression du repertoire temporaire ... "
cd $current_dir
rm -rf /home/$(whoami)/osplinst
echo "OK"

echo "########################################################"
echo
