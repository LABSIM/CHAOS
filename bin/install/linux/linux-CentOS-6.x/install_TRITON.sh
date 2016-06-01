#!/bin/bash

# get current directory
current_dir=$PWD

# source user configured versions 
source user-config-versions.sh
source ../../../../script/linux/wait_for_PID.sh

# go to local dir
cd /tmp_user/$(hostname)/$(whoami)
mkdir tritoninst
cd tritoninst

echo; echo "## BEGIN"; echo

echo "########################################################"
echo "  FFTS : Decompression du/des package(s)"
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "tar -xzvf /data/CentOS_6.x/archive/fftss-$FFTSS_INSTALL_TARGET_VERSION.tar.gz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tDecompression de FFTSS $FFTSS_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - FFTSS $FFTSS_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "########################################################"
echo "  FFTS : Configure, build & install"
echo "########################################################"

cd fftss-*

echo "#!/bin/bash" > exec.sh
echo "./configure --prefix=/home/$(whoami)/Progiciels/fftss-$FFTSS_INSTALL_TARGET_VERSION --enable-shared" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tConfiguration de FFTSS $FFTSS_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - FFTSS $FFTSS_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCompilation de FFTSS $FFTSS_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - FFTSS $FFTSS_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tInstallation de FFTSS $FFTSS_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - FFTSS $FFTSS_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

cd ..

echo "########################################################"
echo "  Triton : Decompression du/des package(s)"
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "tar -xvf /data/CentOS_6.x/sundog/Triton-SDK-FullSource.tgz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tDecompression de Triton $TRITON_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - Triton $TRITON_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "########################################################"
echo "  Triton : CMake, Build & Install"
echo "########################################################"*

cd triton-*

echo "#!/bin/bash" > exec.sh
echo "cmake -DCMAKE_INSTALL_PREFIX=/home/$(whoami)/Progiciels/triton-$TRITON_INSTALL_TARGET_VERSION -DFFTSS_INCLUDE_DIR=/home/$(whoami)/Progiciels/fftss-$FFTSS_INSTALL_TARGET_VERSION/include -DFFTSS_LIBRARY=/home/$(whoami)/Progiciels/fftss-$FFTSS_INSTALL_TARGET_VERSION/lib/libfftss.so -DLIB_IOMP5=/usr/local/intel/studio/2015/composer_xe_2015.6.233/compiler/lib/intel64/libiomp5.so ." >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tConfiguration de Triton $TRITON_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - Triton $TRITON_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tBuild de Triton $TRITON_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - Triton $TRITON_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "mkdir /home/$(whoami)/Progiciels/triton-$TRITON_INSTALL_TARGET_VERSION" >> exec.sh
echo "cp -rf /tmp_user/$(hostname)/$(whoami)/tritoninst/triton-sdk-fullsource/docs /home/$(whoami)/Progiciels/triton-$TRITON_INSTALL_TARGET_VERSION" >> exec.sh
echo "cp -rf /tmp_user/$(hostname)/$(whoami)/tritoninst/triton-sdk-fullsource/lib /home/$(whoami)/Progiciels/triton-$TRITON_INSTALL_TARGET_VERSION" >> exec.sh
echo "cp -rf /tmp_user/$(hostname)/$(whoami)/tritoninst/triton-sdk-fullsource/Public* /home/$(whoami)/Progiciels/triton-$TRITON_INSTALL_TARGET_VERSION" >> exec.sh
echo "cp -rf /tmp_user/$(hostname)/$(whoami)/tritoninst/triton-sdk-fullsource/Resources /home/$(whoami)/Progiciels/triton-$TRITON_INSTALL_TARGET_VERSION" >> exec.sh
echo "cp -rf /tmp_user/$(hostname)/$(whoami)/tritoninst/triton-sdk-fullsource/Samples /home/$(whoami)/Progiciels/triton-$TRITON_INSTALL_TARGET_VERSION" >> exec.sh
echo "cp -rf /tmp_user/$(hostname)/$(whoami)/tritoninst/triton-sdk-fullsource/third* /home/$(whoami)/Progiciels/triton-$TRITON_INSTALL_TARGET_VERSION" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tInstallation de Triton $TRITON_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - Triton $TRITON_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "########################################################"
echo "  Suppression du repertoire temporaire"
cd $current_dir
rm -rf /tmp_user/$(hostname)/$(whoami)/tritoninst
echo "########################################################"

echo; echo "## END"; echo
