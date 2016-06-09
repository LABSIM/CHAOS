#!/bin/bash

# get current directory
current_dir=$PWD

# source user configured versions 
source user-config-versions.sh
source ../../wait_for_PID.sh

# go to local dir
cd /tmp_user/$(hostname)/$(whoami)
mkdir perlinst
cd perlinst

echo; echo "## BEGIN"; echo

echo "########################################################"
echo "                           PERL                        "
echo "########################################################"

echo "#!/bin/bash" > exec.sh
echo "tar -xvf /data/CentOS_6.x/archive/perl-$PERL_INSTALL_TARGET_VERSION.tar.gz" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tDecompression de Perl $PERL_INSTALL_TARGET_VERSION ..."
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - Perl $PERL_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

cd perl-*

echo "#!/bin/bash" > exec.sh
echo "./Configure -de -Dcc=gcc -Duse64bitall -Dprefix=/home/$(whoami)/Progiciels/perl-$PERL_INSTALL_TARGET_VERSION" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tConfiguration de Perl $PERL_INSTALL_TARGET_VERSION ..."
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - Perl $PERL_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
## bug [ http://serverfault.com/questions/145288/make-error-when-compiling-perl-5-12-1-rhel-5-5 ]
echo "unset CPATH" >> exec.sh 
## /bug
echo "make" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tBuild de Perl $PERL_INSTALL_TARGET_VERSION ..."
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - Perl $PERL_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make test" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tTest de Perl $PERL_INSTALL_TARGET_VERSION ..."
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - Perl $PERL_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "#!/bin/bash" > exec.sh
echo "make install" >> exec.sh
echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh
echo -ne "\tInstall de Perl $PERL_INSTALL_TARGET_VERSION ..."
chmod u+x exec.sh
gnome-terminal --working-directory $PWD --title="LABSIM - Perl $PERL_INSTALL_TARGET_VERSION" --command "./exec.sh" --window
sleep 0.2
PID=$(pgrep exec.sh)
wait_for_PID $PID
echo "OK"

echo "########################################################"
echo -ne "\tSuppression du repertoire temporaire ... "
cd $current_dir
rm -rf /tmp_user/$(hostname)/$(whoami)/perlinst
echo "OK"
echo "########################################################"

echo; echo "## END"; echo
