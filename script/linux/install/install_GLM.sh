#!/bin/bash

# get current directory
current_dir=$PWD

# source user configured versions 
source user-config.versions.sh

# go to dir
cd /home/$(whoami)
mkdir glminst
cd glminst

echo; echo "## BEGIN"; echo

echo "########################################################"
echo "  Decompression du/des package(s)"
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "unzip /data/CentOS_6.3/archive/glm-$GLM_INSTALL_TARGET_VERSION.zip" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tDecompression de GLM $GLM_INSTALL_TARGET_VERSION ..."
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
echo "OK"

cd glm

echo "########################################################"
echo "  CMake, build  & install"
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "cmake . -Wno-dev -DCMAKE_INSTALL_PREFIX=/home/$(whoami)/Progiciels/glm-$GLM_INSTALL_TARGET_VERSION -DCMAKE_BUILD_TYPE=Release -DGLM_TEST_ENABLE=TRUE -DGLM_TEST_ENABLE_CXX_0X=FALSE -DGLM_TEST_ENABLE_CXX_11=FALSE -DGLM_TEST_ENABLE_CXX_1Y=FALSE -DGLM_TEST_ENABLE_CXX_98=FALSE -DGLM_TEST_ENABLE_CXX_PEDANTIC=FALSE -DGLM_TEST_ENABLE_FAST_MATH=FALSE -DGLM_TEST_ENABLE_SIMD_AVX=FALSE -DGLM_TEST_ENABLE_SIMD_AVX2=FALSE -DGLM_TEST_ENABLE_SIMD_SSE2=FALSE -DGLM_TEST_ENABLE_SIMD_SSE3=FALSE -DGLM_TEST_FORCE_PURE=FALSE" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tConfiguration de GLM $GLM_INSTALL_TARGET_VERSION ..."
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make -j4 install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tBuild & Install de GLM $GLM_INSTALL_TARGET_VERSION ..."
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
echo "OK"

echo "########################################################"
echo "  Suppression du repertoire temporaire"
cd $current_dir
rm -rf /home/$(whoami)/glminst
echo "########################################################"

echo; echo "## END"; echo

