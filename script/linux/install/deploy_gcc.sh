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

target=$1

# get current directory
current_dir=$PWD

source ../../../conf/versions.sh
cd /home/${target}/gcc_env

echo "################################################"
echo " Creation des fichiers de configuration pour ld "
echo "################################################"
echo -e "\tCreation de /etc/ld.so.conf.d/gmp-$GMP_VERSION.conf"
echo "/home/${target}/Progiciels/gmp-$GMP_VERSION/lib" > /etc/ld.so.conf.d/gmp-$GMP_VERSION.conf

echo -e "\tCreation de /etc/ld.so.conf.d/mpfr-$MPFR_VERSION.conf"
echo "/home/${target}/Progiciels/mpfr-$MPFR_VERSION/lib" > /etc/ld.so.conf.d/mpfr-$MPFR_VERSION.conf

echo -e "\tCreation de /etc/ld.so.conf.d/mpc-$MPC_VERSION.conf"
echo "/home/${target}/Progiciels/mpc-$MPC_VERSION/lib" > /etc/ld.so.conf.d/mpc-$MPC_VERSION.conf

echo -e "\tCreation de /etc/ld.so.conf.d/autogen-$AUTOGEN_VERSION.conf"
echo "/home/${target}/Progiciels/autogen-$AUTOGEN_VERSION/lib" > /etc/ld.so.conf.d/autogen-$AUTOGEN_VERSION.conf

echo -e "\tCreation de /etc/ld.so.conf.d/gcc-$GCC_VERSION.conf"
GCJ=$(ls /home/${target}/Progiciels/gcc-$GCC_VERSION/lib | grep gcj-$GCC_VERSION)
echo "/home/${target}/Progiciels/gcc-$GCC_VERSION/libexec/gcc/x86_64-unknown-linux-gnu/$GCC_VERSION" > /etc/ld.so.conf.d/gcc-$GCC_VERSION.conf
echo "/home/${target}/Progiciels/gcc-$GCC_VERSION/lib/../lib64" >> /etc/ld.so.conf.d/gcc-$GCC_VERSION.conf
echo "/home/${target}/Progiciels/gcc-$GCC_VERSION/lib/../lib64/$GCJ" >> /etc/ld.so.conf.d/gcc-$GCC_VERSION.conf
echo "/home/${target}/Progiciels/gcc-$GCC_VERSION/lib/../lib" >> /etc/ld.so.conf.d/gcc-$GCC_VERSION.conf
echo "/home/${target}/Progiciels/gcc-$GCC_VERSION/lib/../lib/$GCJ" >> /etc/ld.so.conf.d/gcc-$GCC_VERSION.conf
echo "/home/${target}/Progiciels/gcc-$GCC_VERSION/lib/gcc/x86_64-unknown-linux-gnu/$GCC_VERSION" >> /etc/ld.so.conf.d/gcc-$GCC_VERSION.conf
echo "/home/${target}/Progiciels/gcc-$GCC_VERSION/lib/gcc/x86_64-unknown-linux-gnu/$GCC_VERSION/32" >> /etc/ld.so.conf.d/gcc-$GCC_VERSION.conf

echo "################################################"
echo
echo "#############################################"
echo "  Deplacement des lib debug pour GDB de GCC  "
mkdir -p /usr/share/gdb/auto-load/home/${target}/Progiciels/gcc-$GCC_VERSION/{lib,lib64}
mv -f /home/${target}/Progiciels/gcc-$GCC_VERSION/lib/libstdc++.so.*-gdb.py /usr/share/gdb/auto-load/home/${target}/Progiciels/gcc-$GCC_VERSION/lib/.
mv -f /home/${target}/Progiciels/gcc-$GCC_VERSION/lib64/libstdc++.so.*-gdb.py /usr/share/gdb/auto-load/home/${target}/Progiciels/gcc-$GCC_VERSION/lib64/.
echo "#############################################"
echo
echo "#############################################"
echo "           Configuration de ld               " 
ldconfig
echo "#############################################"
echo
echo "#############################################"
echo "     Suppression du dossier temporaire       " 
cd $current_dir
rm -rf /home/${target}/gcc_env
echo "#############################################"

echo



