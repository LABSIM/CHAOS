#!/bin/bash

# get current directory
current_dir=$PWD

# source user configured versions 
source user-config-versions.sh

source wait_for_PID.sh

# go to dir
cd /home/$(whoami)
mkdir qtinst
cd qtinst

echo; echo "## BEGIN"; echo

echo "########################################################"
echo " QT - Decompression du/des package(s)"
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "tar -xzvf /data/CentOS_7.x/archive/qt-*-$QT_INSTALL_TARGET_VERSION.tar.gz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tDecompression de QT $QT_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
PID=`pgrep exec.sh`
wait_for_PID $PID
echo "OK"

echo "########################################################"
echo " QT - Configure, build & install"
echo "########################################################"

cd qt-*

echo "#!/bin/bash" > exec.sh
echo "./configure --platform=linux-g++-64 --prefix=/home/$(whoami)/Progiciels/qt-$QT_INSTALL_TARGET_VERSION -verbose -opensource -confirm-license -release -c++11 -shared -largefile -accessibility -pkg-config -qml-debug -reduce-relocations -optimized-qmake -qt-xkbcommon-x11 -qt-pcre -system-libpng -system-libjpeg -system-freetype -system-zlib -system-xcb -xinput2 -xcb-xlib -mtdev -icu -fontconfig -glib -pulseaudio -alsa -openssl -gtkstyle -opengl desktop -gui -widgets -no-journald -skip qtwebkit -no-use-gold-linker -nomake tests -nomake examples -continue" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tConfiguration de QT $QT_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
PID=`pgrep exec.sh`
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCompilation de QT $QT_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
PID=`pgrep exec.sh`
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tInstallation de QT $QT_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
PID=`pgrep exec.sh`
wait_for_PID $PID
echo "OK"

echo "########################################################"
echo " QT - Copie des libembedded-widget ... "
echo "########################################################"
cd $current_dir
cp -r /data/CentOS_7.x/conf/libembedded-widget/ /home/$(whoami)/Progiciels/qt-$QT_INSTALL_TARGET_VERSION
echo "OK"; echo

echo "########################################################"
echo "  Suppression du repertoire temporaire... "
rm -rf /home/$(whoami)/qtinst
echo "########################################################"

echo; echo "## END"; echo

