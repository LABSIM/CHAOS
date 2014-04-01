#!/bin/bash

# get current directory
current_dir=$PWD

source ../../../conf/versions.sh
cd /home/$(whoami)
mkdir boostinst
cd boostinst

echo "########################################################"
echo "#!/bin/bash" > exec.sh
echo "tar -xzvf /data/CentOS_6.3/archive/boost_$BOOST_MAJ_VER\_$BOOST_MIN_VER\_$BOOST_REV_VER.tar.gz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n "Decompression de boost $BOOST_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"

echo "########################################################"
cd boost_*
echo "#!/bin/bash" > exec.sh
echo "./bootstrap.sh" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n "Construction de bjam ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"

echo "########################################################"
cp -f /data/CentOS_6.3/conf/boost_$BOOST_MAJ_VER\_$BOOST_MIN_VER\_$BOOST_REV_VER/tools/build/v2/user-config.jam ./tools/build/v2/user-config.jam
echo "#!/bin/bash" > exec.sh
echo "./b2 --prefix=/home/$(whoami)/Progiciels/boost-$BOOST_VERSION toolset=gcc variant=release link=shared threading=multi runtime-link=shared -j4 install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n "Compilation et installation de boost $BOOST_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"

echo "########################################################"
echo -n "Suppression du repertoire temporaire ... "
cd $current_dir
rm -rf /home/$(whoami)/boostinst
echo "OK"

echo "########################################################"
echo
