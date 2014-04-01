#!/bin/bash

# get current directory
current_dir=$PWD

source ../../../conf/versions.sh

echo "########################################################"
echo "\tCopie du repertoire temporaire               "
cp -r /data/CentOS_6.3/conf/gcc_env /home/$(whoami)
cd /home/$(whoami)/gcc_env

echo "########################################################"
echo "\tDecompression des Packages                 "
echo "########################################################"
echo "#!/bin/bash" > exec.sh
echo "tar -xvf gmp-$GMP_VERSION.tar.bz2" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tDecompression de GMP $GMP_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "tar -xvf mpfr-$MPFR_VERSION.tar.gz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e " \tDecompression de MPFR $MPFR_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "tar -xvf mpc-$MPC_VERSION.tar.gz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tDecompression de MPC $MPC_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "tar -xvf autogen-$AUTOGEN_VERSION.tar.gz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tDecompression de AutoGen $AUTOGEN_VERSION  ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "tar -xvf gcc-$GCC_VERSION.tar.gz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tDecompression de GCC $GCC_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"

echo "########################################################"
echo "\tConfiguration et make"
echo "########################################################"
echo "#!/bin/bash" > exec.sh
echo "cd gmp-$GMP_VERSION" >> exec.sh
echo "./configure --prefix=/home/$(whoami)/Progiciels/gmp-$GMP_VERSION" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tConfiguration de GMP $GMP_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd gmp-$GMP_VERSION" >> exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tCompilation de GMP $GMP_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd gmp-$GMP_VERSION" >> exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tInstallation de GMP $GMP_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd mpfr-$MPFR_VERSION" >> exec.sh
echo "./configure --prefix=/home/$(whoami)/Progiciels/mpfr-$MPFR_VERSION --with-gmp=/home/$(whoami)/Progiciels/gmp-$GMP_VERSION" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tConfiguration de MPFR $MPFR_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd  mpfr-$MPFR_VERSION" >> exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tCompilation de MPFR $MPFR_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd  mpfr-$MPFR_VERSION" >> exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tInstallation de MPFR $MPFR_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd mpc-$MPC_VERSION" >> exec.sh
echo "./configure --prefix=/home/$(whoami)/Progiciels/mpc-$MPC_VERSION --with-gmp=/home/$(whoami)/Progiciels/gmp-$GMP_VERSION --with-mpfr=/home/$(whoami)/Progiciels/mpfr-$MPFR_VERSION" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tConfiguration de MPC $MPC_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd  mpc-$MPC_VERSION" >> exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tCompilation de MPC $MPC_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd  mpc-$MPC_VERSION" >> exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tInstallation de MPC $MPC_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd autogen-$AUTOGEN_VERSION" >> exec.sh
echo "./configure --prefix=/home/$(whoami)/Progiciels/autogen-$AUTOGEN_VERSION" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tConfiguration de AutoGen $AUTOGEN_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd  autogen-$AUTOGEN_VERSION" >> exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tCompilation de AutoGen $AUTOGEN_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd  autogen-$AUTOGEN_VERSION" >> exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tInstallation de AutoGen $AUTOGEN_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "mkdir GCC-$GCC_VERSION" >> exec.sh
echo "cd GCC-$GCC_VERSION" >> exec.sh
echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/$(whoami)/Progiciels/mpfr-$MPFR_VERSION/lib:/home/$(whoami)/Progiciels/mpc-$MPC_VERSION/lib:/home/$(whoami)/Progiciels/gmp-$GMP_VERSION/lib:/home/$(whoami)/Progiciels/autogen-$AUTOGEN_VERSION/lib" >> exec.sh
echo "../gcc-$GCC_VERSION/configure --prefix=/home/$(whoami)/Progiciels/gcc-$GCC_VERSION --mandir=/home/$(whoami)/Progiciels/gcc-$GCC_VERSION/share/man --infodir=/home/$(whoami)/Progiciels/gcc-$GCC_VERSION/share/info --enable-shared --enable-threads=posix --enable-checking=yes --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-libgcj-multifile --enable-languages=c,c++,objc,obj-c++,java,fortran --disable-dssi --enable-plugin --with-java-home=/usr/lib/jvm/java-1.5.0-gcj-1.5.0.0/jre --with-cpu=generic --with-gmp=/home/$(whoami)/Progiciels/gmp-$GMP_VERSION --with-mpfr=/home/$(whoami)/Progiciels/mpfr-$MPFR_VERSION --with-mpc=/home/$(whoami)/Progiciels/mpc-$MPC_VERSION" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tConfiguration de  GCC $GCC_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd  GCC-$GCC_VERSION" >> exec.sh
echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/$(whoami)/Progiciels/mpfr-$MPFR_VERSION/lib:/home/$(whoami)/Progiciels/mpc-$MPC_VERSION/lib:/home/$(whoami)/Progiciels/gmp-$GMP_VERSION/lib:/home/$(whoami)/Progiciels/autogen-$AUTOGEN_VERSION/lib" >> exec.sh
echo "make -j4" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tCompilation de GCC $GCC_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"
echo "#!/bin/bash" > exec.sh
echo "cd  GCC-$GCC_VERSION" >> exec.sh
echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/$(whoami)/Progiciels/mpfr-$MPFR_VERSION/lib:/home/$(whoami)/Progiciels/mpc-$MPC_VERSION/lib:/home/$(whoami)/Progiciels/gmp-$GMP_VERSION/lib:/home/$(whoami)/Progiciels/autogen-$AUTOGEN_VERSION/lib" >> exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -n -e "\tInstallation de GCC $GCC_VERSION ... "
chmod u+x exec.sh
gnome-terminal --disable-factory --working-directory $PWD --command "./exec.sh" --window
#konsole --profile Shell --nofork --workdir $PWD -e "./exec.sh"
echo "OK"
echo -e "\t-------------------------------------------------"

echo "########################################################"
rm exec.sh

cd $current_dir
