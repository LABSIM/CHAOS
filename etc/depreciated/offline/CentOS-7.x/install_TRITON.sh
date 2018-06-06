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

# go to dir
cd /home/$(whoami)
mkdir tritoninst
cd tritoninst

echo; echo "## BEGIN"; echo

echo "########################################################"
echo "  FFTS : Decompression du/des package(s)"
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "tar -xzvf /data/CentOS_7.x/archive/fftss-$FFTSS_INSTALL_TARGET_VERSION.tar.gz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tDecompression de FFTSS $FFTSS_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
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
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tCompilation de FFTSS $FFTSS_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tInstallation de FFTSS $FFTSS_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"


cd ..

echo "########################################################"
echo "  Triton : Decompression du/des package(s)"
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "tar -xvf /data/CentOS_7.x/sundog/Triton-SDK-FullSource.tgz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tDecompression du SDK Triton $TRITON_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "########################################################"
echo "  Triton : CMake, Build & Install"
echo "########################################################"*

cd triton-*

echo "#!/bin/bash" > exec.sh
echo "cmake -DCMAKE_INSTALL_PREFIX=/home/$(whoami)/Progiciels/triton-$TRITON_INSTALL_TARGET_VERSION -DFFTSS_INCLUDE_DIR=/home/$(whoami)/Progiciels/fftss-$FFTSS_INSTALL_TARGET_VERSION/include -DFFTSS_LIBRARY=/home/$(whoami)/Progiciels/fftss-$FFTSS_INSTALL_TARGET_VERSION/lib/libfftss.so ." >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tConfiguration du SDK Triton $TRITON_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tBuild du SDK Triton $TRITON_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "mkdir /home/$(whoami)/Progiciels/triton-$TRITON_INSTALL_TARGET_VERSION" >> exec.sh
echo "cp -rf /home/$(whoami)/tritoninst/triton-sdk-fullsource/docs /home/$(whoami)/Progiciels/triton-$TRITON_INSTALL_TARGET_VERSION" >> exec.sh
echo "cp -rf /home/$(whoami)/tritoninst/triton-sdk-fullsource/lib /home/$(whoami)/Progiciels/triton-$TRITON_INSTALL_TARGET_VERSION" >> exec.sh
echo "cp -rf /home/$(whoami)/tritoninst/triton-sdk-fullsource/Public* /home/$(whoami)/Progiciels/triton-$TRITON_INSTALL_TARGET_VERSION" >> exec.sh
echo "cp -rf /home/$(whoami)/tritoninst/triton-sdk-fullsource/Resources /home/$(whoami)/Progiciels/triton-$TRITON_INSTALL_TARGET_VERSION" >> exec.sh
echo "cp -rf /home/$(whoami)/tritoninst/triton-sdk-fullsource/Samples /home/$(whoami)/Progiciels/triton-$TRITON_INSTALL_TARGET_VERSION" >> exec.sh
echo "cp -rf /home/$(whoami)/tritoninst/triton-sdk-fullsource/third* /home/$(whoami)/Progiciels/triton-$TRITON_INSTALL_TARGET_VERSION" >> exec.sh
echo "cp -f /home/$(whoami)/tritoninst/triton-sdk-fullsource/license-full.txt /home/$(whoami)/Progiciels/triton-$TRITON_INSTALL_TARGET_VERSION" >> exec.sh
echo "cp -f /home/$(whoami)/tritoninst/triton-sdk-fullsource/releasenotes.txt /home/$(whoami)/Progiciels/triton-$TRITON_INSTALL_TARGET_VERSION" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tInstallation du SDK Triton $TRITON_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "########################################################"
echo "  Suppression du repertoire temporaire"
cd $current_dir
rm -rf /home/$(whoami)/tritoninst
echo "########################################################"

echo; echo "## END"; echo