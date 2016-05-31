#!/bin/bash

# get current directory
current_dir=$PWD

if [ $(whoami) != "root" ] 
then
  echo
  echo "##############################################"
  echo " Vous devez etre root pour executer ce script "
  echo "##############################################"
  echo
  exit
fi

if [ $# != 1 ]
then
  echo
  echo "##############################################"
  echo " Usage : COMMAND [USER_TARGETED]"
  echo "##############################################"
  echo
  exit
fi

# source user configured versions 
source user-config-versions.sh
source ../../../../script/linux/wait_for_PID.sh

# go to local dir
cd /tmp_user/$(hostname)/$(whoami)
mkdir tritoninst
cd tritoninst

echo; echo "## BEGIN"; echo

echo "########################################################"
echo "  Triton : Copie & Decompression du/des package(s)"
echo "########################################################"


echo -ne "\tCopie du SDK Triton $TRITON_INSTALL_TARGET_VERSION ... "
cp /data/CentOS_6.3/sundog/install-triton-fullsource.run .
echo "OK"

echo -ne "\tExecution du script du SDK Triton $TRITON_INSTALL_TARGET_VERSION ... "
sh install-triton-fullsource.run
echo "OK"

cd ..

echo -ne "\tChangement des droits sur le SDK Triton $TRITON_INSTALL_TARGET_VERSION ... "
chown $1 -R tritoninst
chgrp $1 -R tritoninst
echo "OK"

echo; echo "## END"; echo

exit
