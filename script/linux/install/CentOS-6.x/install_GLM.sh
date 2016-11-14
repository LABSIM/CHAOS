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
mkdir glminst
cd glminst

echo; echo "## BEGIN"; echo

echo "########################################################"
echo "                         GLM                            "
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "unzip /data/CentOS_6.x/archive/glm-$GLM_INSTALL_TARGET_VERSION*.zip" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tDecompression de GLM $GLM_INSTALL_TARGET_VERSION ..."
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - GLM $GLM_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

cd glm

echo "#!/bin/bash" > exec.sh
echo "cmake . -Wno-dev -DCMAKE_INSTALL_PREFIX=/home/$(whoami)/Progiciels/glm-$GLM_INSTALL_TARGET_VERSION -DCMAKE_BUILD_TYPE=Release -DGLM_TEST_ENABLE=TRUE -DGLM_TEST_ENABLE_CXX_0X=FALSE -DGLM_TEST_ENABLE_CXX_11=FALSE -DGLM_TEST_ENABLE_CXX_1Y=FALSE -DGLM_TEST_ENABLE_CXX_98=FALSE -DGLM_TEST_ENABLE_CXX_PEDANTIC=FALSE -DGLM_TEST_ENABLE_FAST_MATH=FALSE -DGLM_TEST_ENABLE_SIMD_AVX=FALSE -DGLM_TEST_ENABLE_SIMD_AVX2=FALSE -DGLM_TEST_ENABLE_SIMD_SSE2=FALSE -DGLM_TEST_ENABLE_SIMD_SSE3=FALSE -DGLM_TEST_FORCE_PURE=FALSE" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tConfiguration de GLM $GLM_INSTALL_TARGET_VERSION ..."
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - GLM $GLM_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make -j4 install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tBuild & Install de GLM $GLM_INSTALL_TARGET_VERSION ..."
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - GLM $GLM_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "########################################################"
echo "  Suppression du repertoire temporaire"
cd $current_dir
rm -rf /tmp_user/$(hostname)/$(whoami)/glminst
echo "########################################################"

echo; echo "## END"; echo

