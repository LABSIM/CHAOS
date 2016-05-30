#!/bin/bash

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

# build temporary progiciels home directory
PRO_HOME=/home/$1/Progiciels
if [ ! -d "$PRO_HOME" ]; then
  echo
  echo "##############################################"
  echo " Le répertoire $PRO_HOME n'existe pas, mkdir ? "
  echo "##############################################"
  echo
  exit
fi

echo "#############################################"
echo "  Run a clean DDS-readymade shell" 
echo "#############################################"

# run new local terminal to install ospl
sudo -u $1 env DEVTK_REQUIRE_CLEAN_DDS_INSTALL_ENVIRONMENT=1 bash

echo; echo "## END"; echo


