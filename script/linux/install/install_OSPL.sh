#!/bin/bash

# get current directory
current_dir=$PWD

# source user configured versions 
source user-config.versions.sh

# go to dir
cd /home/$(whoami)
mkdir osplinst
cd osplinst

echo; echo "## BEGIN"; echo

echo "########################################################"
echo "  Decompression du/des package(s)"
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "tar -xvzf /data/CentOS_6.3/archive/OpenSpliceDDSV$OSPL_INSTALL_TARGET_VERSION-src.tar.gz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tDecompression de OpenSpliceDDS $OSPL_INSTALL_TARGET_VERSION ..."
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
echo "OK"

cd OpenSplice

echo "########################################################"
echo "  Configure, build & install"
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "./configure" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tConfiguration de OpenSpliceDDS ..."
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
echo "OK"

echo -ne "\tSourcing de la configuration d'OpenSpliceDDS ..."
source envs-*.sh
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tBuild & Install d'OpenSpliceDDS ..."
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "mkdir /home/$(whoami)/Progiciels/opensplicedds-$OSPL_INSTALL_TARGET_VERSION" >> exec.sh
echo "mkdir /home/$(whoami)/Progiciels/opensplicedds-$OSPL_INSTALL_TARGET_VERSION/log " >> exec.sh
echo "mkdir /home/$(whoami)/Progiciels/opensplicedds-$OSPL_INSTALL_TARGET_VERSION/store " >> exec.sh
echo "mkdir /home/$(whoami)/Progiciels/opensplicedds-$OSPL_INSTALL_TARGET_VERSION/config " >> exec.sh
echo "cp -r install/HDE /home/$(whoami)/Progiciels/opensplicedds-$OSPL_INSTALL_TARGET_VERSION" >> exec.sh
echo "cp -r install/RTS /home/$(whoami)/Progiciels/opensplicedds-$OSPL_INSTALL_TARGET_VERSION" >> exec.sh
echo "cp -r install/VC /home/$(whoami)/Progiciels/opensplicedds-$OSPL_INSTALL_TARGET_VERSION" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCopie des environments d'OpenSpliceDDS et creation des directories Progiciels..."
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window

sed -i "s|@@INSTALLDIR@@|/home/$(whoami)/Progiciels/opensplicedds-$OSPL_INSTALL_TARGET_VERSION|g" /home/$(whoami)/Progiciels/opensplicedds-$OSPL_INSTALL_TARGET_VERSION/HDE/x86_64.linux2.6/release.com
sed -i "s|@@INSTALLDIR@@|/home/$(whoami)/Progiciels/opensplicedds-$OSPL_INSTALL_TARGET_VERSION|g" /home/$(whoami)/Progiciels/opensplicedds-$OSPL_INSTALL_TARGET_VERSION/RTS/x86_64.linux2.6/release.com

echo "OK"

echo "########################################################"
echo "  Suppression du repertoire temporaire"
cd $current_dir
rm -rf /home/$(whoami)/osplinst
echo "########################################################"

echo; echo "## END"; echo

