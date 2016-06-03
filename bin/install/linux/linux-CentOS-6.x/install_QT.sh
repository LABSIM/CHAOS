#!/bin/bash

# get current directory
current_dir=$PWD

# source user configured versions 
source user-config-versions.sh
source ../../../../script/linux/wait_for_PID.sh

# go to local dir
cd /tmp_user/$(hostname)/$(whoami)
mkdir qtinst
cd qtinst

echo; echo "## BEGIN"; echo

echo "########################################################"
echo "                         QT                             "
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "tar -xzvf /data/CentOS_6.x/archive/qt-*-$QT_INSTALL_TARGET_VERSION.tar.gz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tDecompression de QT $QT_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - QT $QT_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

cd qt-*

echo "#!/bin/bash" > exec.sh
echo "./configure --prefix=/home/$(whoami)/Progiciels/qt-$QT_INSTALL_TARGET_VERSION -verbose -opensource -confirm-license -release -c++11 -shared -largefile -accessibility -pkg-config -qml-debug -reduce-relocations -optimized-qmake -qt-xkbcommon-x11 -qt-pcre -system-libpng -system-libjpeg -system-freetype -system-zlib -system-xcb -xinput2 -xcb-xlib -mtdev -icu -fontconfig -glib -pulseaudio -alsa -openssl -gtkstyle -opengl desktop -gui -widgets -no-journald -skip qtwebkit -no-use-gold-linker -nomake tests -nomake examples -continue" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh-stl
echo -ne "\tConfiguration de QT $QT_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - QT $QT_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCompilation de QT $QT_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - QT $QT_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
wait_for_PID $(pgrep exec.sh)
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tInstallation de QT $QT_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - QT $QT_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "########################################################"
echo "         QT - Copie des libembedded-widget ...          "
echo "########################################################"
cd $current_dir
cp -r /data/CentOS_6.x/conf/libembedded-widget/ /home/$(whoami)/Progiciels/qt-$QT_INSTALL_TARGET_VERSION
echo "OK"; echo

echo "########################################################"
echo "  Suppression des repertoires temporaires... "
cd $current_dir
rm -rf /tmp_user/$(hostname)/$(whoami)/qtinst
echo "########################################################"

echo; echo "## END"; echo

