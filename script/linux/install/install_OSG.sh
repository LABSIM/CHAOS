#!/bin/bash

# get current directory
current_dir=$PWD

source ../../../conf/versions.sh
cd /home/$(whoami)
mkdir osginst
cd osginst

echo "########################################################"
echo "#!/bin/bash" > exec.sh
echo "tar -xzvf /data/CentOS_6.3/archive/nvidia-texture-tools-$NVTT_VERSION.tar.gz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n "Decompression de nvidia-texture tools $NVTT_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"

echo "########################################################"
cd nvidia-texture-tools
echo "#!/bin/bash" > exec.sh
echo "./configure --prefix=/home/$(whoami)/Progiciels/nvidia-texture-tools-$NVTT_VERSION" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n "Configuration de nvidia-texture tools $NVTT_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"

echo "########################################################"
cp -f /data/CentOS_6.3/conf/nvidia-texture-tools/src/nvcore/Debug.cpp ./src/nvcore/
echo "#!/bin/bash" > exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n "Compilation de nvidia-texture tools $NVTT_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"

echo "########################################################"
echo "#!/bin/bash" > exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n "Installation de nvidia-texture tools $NVTT_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"

echo "########################################################"
cd ..
echo "#!/bin/bash" > exec.sh
echo "unzip /data/CentOS_6.3/archive/OpenSceneGraph-$OSG_VERSION.zip" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n "Decompression de OpenSceneGraph $OSG_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"

echo "########################################################"
cd OpenSceneGraph-*
echo "#!/bin/bash" > exec.sh
echo "export NVTT_DIR=/home/$(whoami)/Progiciels/nvidia-texture-tools-$NVTT_VERSION/" >> exec.sh
echo "cmake -DQT_QMAKE_EXECUTABLE=/home/$(whoami)/Progiciels/QT-$QT_VERSION/bin/qmake -DCMAKE_INSTALL_PREFIX=/home/$(whoami)/Progiciels/OSG-$OSG_VERSION ." >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n "Configuration de OpenSceneGraph $OSG_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"

echo "########################################################"
echo "#!/bin/bash" > exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n "Compilation de OpenSceneGraph $OSG_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"

echo "########################################################"
echo "#!/bin/bash" > exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n "Installation de OpenSceneGraph $OSG_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"

echo "########################################################"
echo -n "Suppression du repertoire temporaire ... "
cd $current_dir
rm -rf /home/$(whoami)/osginst
echo "OK"

echo "########################################################"
echo
