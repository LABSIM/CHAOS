#!/bin/bash

#
# GAIA : required LABSIM ground software ecosystem
# Copyright (C) 2012-2016  Nawfel KINANI
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; see the file COPYING.
# If not, see <http://www.gnu.org/licenses/>.
#

# get current directory
current_dir=$PWD

# source user configured versions 
source user-config-versions.sh
source ../../routine/wait_for_PID.sh

# go to local dir
cd /tmp_user/$(hostname)/$(whoami)
mkdir tritoninst
cd tritoninst

echo; echo "## BEGIN"; echo

echo "########################################################"
echo "                          FFTSS                         "
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
echo "                     Sundog Triton                      "
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
echo "cp -f /tmp_user/$(hostname)/$(whoami)/tritoninst/triton-sdk-fullsource/license-full.txt /home/$(whoami)/Progiciels/triton-$TRITON_INSTALL_TARGET_VERSION" >> exec.sh
echo "cp -f /tmp_user/$(hostname)/$(whoami)/tritoninst/triton-sdk-fullsource/releasenotes.txt /home/$(whoami)/Progiciels/triton-$TRITON_INSTALL_TARGET_VERSION" >> exec.sh
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
