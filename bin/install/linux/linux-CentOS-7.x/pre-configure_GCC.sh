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

# source current versions 
declare LABSIM_DRI_MASK=$(( 1 << 0 ))
declare LABSIM_COMMON_MASK=$(( 1 << 1 ))
declare LABSIM_COLOSSES_MASK=$(( 1 << 2 ))
declare LABSIM_OLYMPIENS_MASK=$(( 1 << 3 ))
declare LABSIM_TITANS_MASK=$(( 1 << 4 ))
declare LABSIM_CONTRACT_MASK=$(( 1 << 5 ))

export LABSIM_DEV_ID=$LABSIM_COMMON_MASK

source ../../../../script/linux/versions.sh
source ../../../../script/linux/wait_for_PID.sh

echo; echo "## BEGIN"; echo

echo "################################################"
echo " Nettoyage des fichiers de configuration ld "
echo "################################################"

echo -e "\tSuppression de /etc/ld.so.conf.d/gmp-$GMP_VERSION.conf"
rm -f  /etc/ld.so.conf.d/gmp-$GMP_VERSION.conf

echo -e "\tSuppression de /etc/ld.so.conf.d/mpfr-$MPFR_VERSION.conf"
rm -f /etc/ld.so.conf.d/mpfr-$MPFR_VERSION.conf

echo -e "\tSuppression de /etc/ld.so.conf.d/mpc-$MPC_VERSION.conf"
rm -f /etc/ld.so.conf.d/mpc-$MPC_VERSION.conf

echo -e "\tSuppression de /etc/ld.so.conf.d/autogen-$AUTOGEN_VERSION.conf"
rm -f /etc/ld.so.conf.d/autogen-$AUTOGEN_VERSION.conf

echo -e "\tSuppression de /etc/ld.so.conf.d/gcc-$GCC_VERSION.conf"
rm -f /etc/ld.so.conf.d/gcc-$GCC_VERSION.conf

echo "#############################################"
echo "  Reconfiguration de ld" 
echo "#############################################"

ldconfig

echo "#############################################"
echo "  Reset local des variables d'environments" 
echo "#############################################"

# run new local terminal to install gcc
sudo -u $1 env DEVTK_REQUIRE_CLEAN_INSTALL_ENVIRONMENT=1 bash

echo; echo "## END"; echo


