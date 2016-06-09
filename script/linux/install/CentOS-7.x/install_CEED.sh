#!/bin/bash

# get current directory
current_dir=$PWD

# source user configured versions 
source user-config-versions.sh
source ../../wait_for_PID.sh

# go to dir
cd /home/$(whoami)
mkdir ceedinst
cd ceedinst

echo; echo "## BEGIN"; echo

echo "########################################################"
echo "#!/bin/bash" > exec.sh
echo "tar -xvf /data/CentOS_7.x/archive/ceed-$CEED_INSTALL_TARGET_VERSION.tar.bz2" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n "Decompression de CEED $CEED_INSTALL_TARGET_VERSION ..."
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

cd ceed-$CEED_INSTALL_TARGET_VERSION

echo "########################################################"
echo "#!/bin/bash" > exec.sh
echo "cmake . -Wno-dev -DCMAKE_INSTALL_PREFIX=/home/$(whoami)/Progiciels/cegui-$CEGUI_INSTALL_TARGET_VERSION -DCMAKE_BUILD_TYPE=Release -DCEGUI_BUILD_LUA_GENERATOR=TRUE -DCEGUI_BUILD_LUA_MODULE=TRUE -DCEGUI_BUILD_PYTHON_MODULES=TRUE -DCEGUI_BUILD_RENDERER_NULL=FALSE -DCEGUI_BUILD_RENDERER_OPENGL=TRUE -DCEGUI_SAMPLES_ENABLED=TRUE -DCEGUI_SAMPLES_USE_OPENGL=TRUE -DCEGUI_SAMPLES_USE_OPENGL3=TRUE -DCEGUI_HAS_PCRE_REGEX=TRUE -DGLFW_H_PATH=$GLFW_INCLUDEDIR -DGLFW_LIB=$GLFW_LIBRARYDIR/libglfw.so -DGLM_H_PATH=$GLM_INCLUDEDIR" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n "Configuration de CEGUI $CEGUI_INSTALL_TARGET_VERSION ..."
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "########################################################"
echo "#!/bin/bash" > exec.sh
echo "make -j4 install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n "Build & Install de CEGUI $CEGUI_INSTALL_TARGET_VERSION ..."
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "########################################################"
echo -n "Suppression du repertoire temporaire ... "
cd $current_dir
rm -rf /home/$(whoami)/ceguiinst
echo "OK"

echo "########################################################"

echo; echo "## END"; echo
