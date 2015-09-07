#!/bin/bash

# get current directory
current_dir=$PWD

# source user configured versions 
source user-config-versions.sh

# go to dir
cd /home/$(whoami)
mkdir qtinst
cd qtinst

echo; echo "## BEGIN"; echo

echo "########################################################"
echo " QT - Decompression du/des package(s)"
echo "########################################################"

#echo "#!/bin/bash" > exec.sh
#echo "tar -xzvf /data/CentOS_6.3/archive/qt-*-$QT_INSTALL_TARGET_VERSION.tar.gz" >> exec.sh
#echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
#echo -ne "\tDecompression de QT $QT_INSTALL_TARGET_VERSION ... "
#chmod u+x exec.sh
#gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#echo "OK"

#echo "########################################################"
#echo " QT - Configure, build & install"
#echo "########################################################"

#cd qt-*

#echo "#!/bin/bash" > exec.sh
#echo "./configure --prefix=/home/$(whoami)/Progiciels/qt-$QT_INSTALL_TARGET_VERSION -verbose -opensource -confirm-license -release -c++11 -shared -largefile -accessibility -pkg-config -qml-debug -reduce-relocations -optimized-qmake -qt-xkbcommon-x11 -qt-pcre -system-libpng -system-libjpeg -system-freetype -system-zlib -system-xcb -xinput2 -xcb-xlib -mtdev -icu -fontconfig -glib -pulseaudio -alsa -openssl -gtkstyle -opengl desktop -gui -widgets -no-journald -skip qtwebkit -no-use-gold-linker -nomake tests -nomake examples -continue" >> exec.sh
#echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh-stl
#echo -ne "\tConfiguration de QT $QT_INSTALL_TARGET_VERSION ... "
#chmod u+x exec.sh
#gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#echo "OK"

#echo "#!/bin/bash" > exec.sh
#echo "make -j4" >> exec.sh
#echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
#echo -ne "\tCompilation de QT $QT_INSTALL_TARGET_VERSION ... "
#chmod u+x exec.sh
#gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#echo "OK"

#echo "#!/bin/bash" > exec.sh
#echo "make install" >> exec.sh
#echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
#echo -ne "\tInstallation de QT $QT_INSTALL_TARGET_VERSION ... "
#chmod u+x exec.sh
#gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#echo "OK"

#echo "########################################################"
#echo " QT - Copie des libembedded-widget ... "
#echo "########################################################"
#cd $current_dir
#cp -r /data/CentOS_6.3/conf/libembedded-widget/ /home/$(whoami)/Progiciels/qt-$QT_INSTALL_TARGET_VERSION
#echo "OK"; echo

# go to dir
cd /home/$(whoami)
mkdir qtcreatortinst
cd qtcreatortinst

echo "########################################################"
echo " QT Creator - Decompression du/des package(s)"
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "tar -xzvf /data/CentOS_6.3/archive/qt-creator-*-$QTCREATOR_INSTALL_TARGET_VERSION.tar.gz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tDecompression de QT Creator $QTCREATOR_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
echo "OK"

echo "########################################################"
echo " QT Creator - Configure, build & install"
echo "########################################################"

cd qt-creator-*

echo "#!/bin/bash" > exec.sh
echo "qmake -r" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh-stl
echo -ne "\tConfiguration de QT Creator $QTCREATOR_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCompilation de QT Creator $QTCREATOR_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make install INSTALL_ROOT=/home/$(whoami)/Progiciels/qt-creator-$QTCREATOR_INSTALL_TARGET_VERSION" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tInstallation de QT Creator $QTCREATOR_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
echo "OK"

echo "########################################################"
echo "  Suppression des repertoires temporaires... "
rm -rf /home/$(whoami)/qtinst
rm -rf /home/$(whoami)/qtcreatortinst
echo "########################################################"

echo; echo "## END"; echo

