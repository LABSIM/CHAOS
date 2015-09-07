#!/bin/bash

# get current directory
current_dir=$PWD

# source user configured versions 
source user-config-versions.sh

echo; echo "## BEGIN"; echo

echo "########################################################"
echo "  Creation du repertoire temporaire               "
cd /home/$(whoami)
mkdir gccinst
cd gccinst

echo "########################################################"
echo "  Decompression du/des package(s)"
echo "########################################################"
echo "#!/bin/bash" > exec.sh
echo "tar -xvf /data/CentOS_6.3/archive/gmp-$GMP_INSTALL_TARGET_VERSION.tar.bz2" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tDecompression de GMP $GMP_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "tar -xvf /data/CentOS_6.3/archive/mpfr-$MPFR_INSTALL_TARGET_VERSION.tar.gz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e " \tDecompression de MPFR $MPFR_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "tar -xvf /data/CentOS_6.3/archive/mpc-$MPC_INSTALL_TARGET_VERSION.tar.gz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tDecompression de MPC $MPC_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "tar -xvf /data/CentOS_6.3/archive/autogen-$AUTOGEN_INSTALL_TARGET_VERSION.tar.gz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tDecompression de AutoGen $AUTOGEN_INSTALL_TARGET_VERSION  ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "tar -xvf /data/CentOS_6.3/archive/gcc-$GCC_INSTALL_TARGET_VERSION.tar.gz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tDecompression de GCC $GCC_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
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
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd gmp-$GMP_INSTALL_TARGET_VERSION" >> exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tCompilation de GMP $GMP_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd gmp-$GMP_INSTALL_TARGET_VERSION" >> exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tInstallation de GMP $GMP_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd mpfr-$MPFR_INSTALL_TARGET_VERSION" >> exec.sh
echo "./configure --prefix=/home/$(whoami)/Progiciels/mpfr-$MPFR_INSTALL_TARGET_VERSION --with-gmp=/home/$(whoami)/Progiciels/gmp-$GMP_INSTALL_TARGET_VERSION" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tConfiguration de MPFR $MPFR_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd  mpfr-$MPFR_INSTALL_TARGET_VERSION" >> exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tCompilation de MPFR $MPFR_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd  mpfr-$MPFR_INSTALL_TARGET_VERSION" >> exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tInstallation de MPFR $MPFR_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd mpc-$MPC_INSTALL_TARGET_VERSION" >> exec.sh
echo "./configure --prefix=/home/$(whoami)/Progiciels/mpc-$MPC_INSTALL_TARGET_VERSION --with-gmp=/home/$(whoami)/Progiciels/gmp-$GMP_INSTALL_TARGET_VERSION --with-mpfr=/home/$(whoami)/Progiciels/mpfr-$MPFR_INSTALL_TARGET_VERSION" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tConfiguration de MPC $MPC_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd  mpc-$MPC_INSTALL_TARGET_VERSION" >> exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tCompilation de MPC $MPC_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd  mpc-$MPC_INSTALL_TARGET_VERSION" >> exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tInstallation de MPC $MPC_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd autogen-$AUTOGEN_INSTALL_TARGET_VERSION" >> exec.sh
echo "./configure --prefix=/home/$(whoami)/Progiciels/autogen-$AUTOGEN_INSTALL_TARGET_VERSION" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tConfiguration de AutoGen $AUTOGEN_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd  autogen-$AUTOGEN_INSTALL_TARGET_VERSION" >> exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tCompilation de AutoGen $AUTOGEN_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd  autogen-$AUTOGEN_INSTALL_TARGET_VERSION" >> exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tInstallation de AutoGen $AUTOGEN_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "mkdir gcc-$GCC_INSTALL_TARGET_VERSION" >> exec.sh
echo "cd gcc-$GCC_INSTALL_TARGET_VERSION" >> exec.sh
echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/$(whoami)/Progiciels/mpfr-$MPFR_INSTALL_TARGET_VERSION/lib:/home/$(whoami)/Progiciels/mpc-$MPC_INSTALL_TARGET_VERSION/lib:/home/$(whoami)/Progiciels/gmp-$GMP_INSTALL_TARGET_VERSION/lib:/home/$(whoami)/Progiciels/autogen-$AUTOGEN_INSTALL_TARGET_VERSION/lib" >> exec.sh
echo "../gcc-$GCC_INSTALL_TARGET_VERSION/configure --prefix=/home/$(whoami)/Progiciels/gcc-$GCC_INSTALL_TARGET_VERSION --mandir=/home/$(whoami)/Progiciels/gcc-$GCC_INSTALL_TARGET_VERSION/share/man --infodir=/home/$(whoami)/Progiciels/gcc-$GCC_INSTALL_TARGET_VERSION/share/info --enable-shared --enable-host-shared --enable-threads=posix --enable-checking=yes --enable-languages=c,c++,fortran,go,java,jit,lto --enable-libgcj-multifile --with-java-home=/usr/lib/jvm/java-1.8.0/jre --with-cpu=generic --with-system-zlib --with-gmp=/home/$(whoami)/Progiciels/gmp-$GMP_INSTALL_TARGET_VERSION --with-mpfr=/home/$(whoami)/Progiciels/mpfr-$MPFR_INSTALL_TARGET_VERSION --with-mpc=/home/$(whoami)/Progiciels/mpc-$MPC_INSTALL_TARGET_VERSION" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tConfiguration de  GCC $GCC_INSTALL_TARGET_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
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
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
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
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"

echo "########################################################"
rm exec.sh

cd $current_dir

echo; echo "## END"; echo
