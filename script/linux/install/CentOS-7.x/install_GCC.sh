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

echo; echo "## BEGIN"; echo

cd /home/$(whoami)
mkdir gccinst
cd gccinst

echo "########################################################"
echo "  Decompression du/des package(s)"
echo "########################################################"
echo "#!/bin/bash" > exec.sh
echo "tar -xvf /data/CentOS_7.x/archive/gmp-$GMP_INSTALL_TARGET_VERSION.tar.bz2" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tDecompression de GMP $GMP_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "tar -xvf /data/CentOS_7.x/archive/mpfr-$MPFR_INSTALL_TARGET_VERSION.tar.gz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e " \tDecompression de MPFR $MPFR_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "tar -xvf /data/CentOS_7.x/archive/mpc-$MPC_INSTALL_TARGET_VERSION.tar.gz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tDecompression de MPC $MPC_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "tar -xvf /data/CentOS_7.x/archive/autogen-$AUTOGEN_INSTALL_TARGET_VERSION.tar.gz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tDecompression de AutoGen $AUTOGEN_INSTALL_TARGET_VERSION  ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "tar -xvf /data/CentOS_7.x/archive/gcc-$GCC_INSTALL_TARGET_VERSION.tar.gz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tDecompression de GCC $GCC_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"
echo -e "\t-------------------------------------------------"

echo "########################################################"
echo " Configure, build & install"
echo "########################################################"
echo "#!/bin/bash" > exec.sh
echo "cd gmp-$GMP_INSTALL_TARGET_VERSION" >> exec.sh
echo "./configure --prefix=/home/$(whoami)/Progiciels/gmp-$GMP_INSTALL_TARGET_VERSION" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tConfiguration de GMP $GMP_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd gmp-$GMP_INSTALL_TARGET_VERSION" >> exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tCompilation de GMP $GMP_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd gmp-$GMP_INSTALL_TARGET_VERSION" >> exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tInstallation de GMP $GMP_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd mpfr-$MPFR_INSTALL_TARGET_VERSION" >> exec.sh
echo "./configure --prefix=/home/$(whoami)/Progiciels/mpfr-$MPFR_INSTALL_TARGET_VERSION --with-gmp=/home/$(whoami)/Progiciels/gmp-$GMP_INSTALL_TARGET_VERSION" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tConfiguration de MPFR $MPFR_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd  mpfr-$MPFR_INSTALL_TARGET_VERSION" >> exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tCompilation de MPFR $MPFR_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd  mpfr-$MPFR_INSTALL_TARGET_VERSION" >> exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tInstallation de MPFR $MPFR_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd mpc-$MPC_INSTALL_TARGET_VERSION" >> exec.sh
echo "./configure --prefix=/home/$(whoami)/Progiciels/mpc-$MPC_INSTALL_TARGET_VERSION --with-gmp=/home/$(whoami)/Progiciels/gmp-$GMP_INSTALL_TARGET_VERSION --with-mpfr=/home/$(whoami)/Progiciels/mpfr-$MPFR_INSTALL_TARGET_VERSION" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tConfiguration de MPC $MPC_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd  mpc-$MPC_INSTALL_TARGET_VERSION" >> exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tCompilation de MPC $MPC_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd  mpc-$MPC_INSTALL_TARGET_VERSION" >> exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tInstallation de MPC $MPC_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd autogen-$AUTOGEN_INSTALL_TARGET_VERSION" >> exec.sh
echo "./configure --prefix=/home/$(whoami)/Progiciels/autogen-$AUTOGEN_INSTALL_TARGET_VERSION" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tConfiguration de AutoGen $AUTOGEN_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd  autogen-$AUTOGEN_INSTALL_TARGET_VERSION" >> exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tCompilation de AutoGen $AUTOGEN_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd  autogen-$AUTOGEN_INSTALL_TARGET_VERSION" >> exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tInstallation de AutoGen $AUTOGEN_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "mkdir gcc-$GCC_INSTALL_TARGET_VERSION" >> exec.sh
echo "cd gcc-$GCC_INSTALL_TARGET_VERSION" >> exec.sh
echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/$(whoami)/Progiciels/mpfr-$MPFR_INSTALL_TARGET_VERSION/lib:/home/$(whoami)/Progiciels/mpc-$MPC_INSTALL_TARGET_VERSION/lib:/home/$(whoami)/Progiciels/gmp-$GMP_INSTALL_TARGET_VERSION/lib:/home/$(whoami)/Progiciels/autogen-$AUTOGEN_INSTALL_TARGET_VERSION/lib" >> exec.sh
echo "../gcc-$GCC_INSTALL_TARGET_VERSION/configure --disable-multilib --prefix=/home/$(whoami)/Progiciels/gcc-$GCC_INSTALL_TARGET_VERSION --mandir=/home/$(whoami)/Progiciels/gcc-$GCC_INSTALL_TARGET_VERSION/share/man --infodir=/home/$(whoami)/Progiciels/gcc-$GCC_INSTALL_TARGET_VERSION/share/info --enable-shared --enable-host-shared --enable-threads=posix --enable-checking=yes --enable-languages=c,c++,fortran,java,jit,lto --enable-libgcj-multifile --with-cpu=generic --with-system-zlib --with-gmp=/home/$(whoami)/Progiciels/gmp-$GMP_INSTALL_TARGET_VERSION --with-mpfr=/home/$(whoami)/Progiciels/mpfr-$MPFR_INSTALL_TARGET_VERSION --with-mpc=/home/$(whoami)/Progiciels/mpc-$MPC_INSTALL_TARGET_VERSION" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tConfiguration de  GCC $GCC_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd  gcc-$GCC_INSTALL_TARGET_VERSION" >> exec.sh
echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/$(whoami)/Progiciels/mpfr-$MPFR_INSTALL_TARGET_VERSION/lib:/home/$(whoami)/Progiciels/mpc-$MPC_INSTALL_TARGET_VERSION/lib:/home/$(whoami)/Progiciels/gmp-$GMP_INSTALL_TARGET_VERSION/lib:/home/$(whoami)/Progiciels/autogen-$AUTOGEN_INSTALL_TARGET_VERSION/lib" >> exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tCompilation de GCC $GCC_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd  gcc-$GCC_INSTALL_TARGET_VERSION" >> exec.sh
echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/$(whoami)/Progiciels/mpfr-$MPFR_INSTALL_TARGET_VERSION/lib:/home/$(whoami)/Progiciels/mpc-$MPC_INSTALL_TARGET_VERSION/lib:/home/$(whoami)/Progiciels/gmp-$GMP_INSTALL_TARGET_VERSION/lib:/home/$(whoami)/Progiciels/autogen-$AUTOGEN_INSTALL_TARGET_VERSION/lib" >> exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tInstallation de GCC $GCC_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"

echo "########################################################"
rm exec.sh

cd $current_dir

echo; echo "## END"; echo

exit

