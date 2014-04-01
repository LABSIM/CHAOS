#!/bin/bash

# get current directory
current_dir=$PWD

source ../../../conf/versions.sh
cd /home/$(whoami)
mkdir qtinst
cd qtinst

echo "########################################################"
echo "#!/bin/bash" > exec.sh
echo "tar -xzvf /data/CentOS_6.3/archive/qt-*-$QT_VERSION.tar.gz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n "Decompression de QT $QT_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"

echo "########################################################"
cd qt-*
echo "#!/bin/bash" > exec.sh
echo "./configure --prefix=/home/$(whoami)/Progiciels/QT-$QT_VERSION -opensource -release -silent -stl -optimized-qmake -no-qt3support -no-webkit -nomake examples -nomake demos -nomake docs" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh-stl
echo -n "Configuration de QT $QT_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"

echo "########################################################"
echo "#!/bin/bash" > exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n "Compilation de QT $QT_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"

echo "########################################################"
echo "#!/bin/bash" > exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n "Installation de QT $QT_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"

echo "########################################################"
echo -n "Copie des libembedded-widget ... "
cd $current_dir
cp -r /data/CentOS_6.3/conf/libembedded-widget/ /home/$(whoami)/Progiciels/QT-$QT_VERSION
echo "OK"

echo "########################################################"
echo -n "Suppression du repertoire temporaire ... "
rm -rf /home/$(whoami)/qtinst
echo "OK"

echo "########################################################"
echo
