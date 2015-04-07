#!/bin/bash

#######################
# global environment config
#
# Ce fichier defini les variables de bases 
#
# 07/02/12 - Kinani Nawfel
#######################

###################################################################
# Home path
###
DEV_HOME=$(eval echo "~$(whoami)")/dev
PRO_HOME=$(eval echo "~$(whoami)")/Progiciels
CODES_HOME=$(eval echo "~$(whoami)")/CODES
BDD_HOME=/data/bdd

export PRO_HOME CODES_HOME BDD_HOME DEV_HOME IDE_HOME

###################################################################
# Versions deployment
###
if [ -f "$DEVTK_ROOT/conf/versions.sh" ]; then 
	source $DEVTK_ROOT/conf/versions.sh
else
	echo "Erreur dans la configuration de votre environment de travail... Contactez les administrateurs: Christian S. ou Nawfel K."
fi

###
# funtions
###

function __internal_labsim_environment() {
	echo -e "\n## BEGIN LABSIM ROUTINES\n" 	\
	&& echo -e ${LABSIM_DEV_DIST} 			\
	&& echo -e "\n## END LABSIM ROUTINES\n"
} # __internal_labsim_environment()

function __internal_labsim_switch_environment() {
	echo -e "\n## BEGIN LABSIM ROUTINES\n" 								\
	&& time sh $DEVTK_ROOT/bin/linux/Labsim_switch_environment.sh "$@"	\
	&& echo -e "\n## END LABSIM ROUTINES\n"
} # __internal_labsim_switch_environment()

###
# long alias
###
alias labsim_env="__internal_labsim_environment"
alias labsim_switch_env="__internal_labsim_switch_environment"

###
# short alias
###
alias le="labsim_env"
alias lse="labsim_switch_env"

###################################################################
# Other
###

# On active le traitement des commandes tierces avec xhost
xhost + > /dev/null 2>&1

###################################################################
# Default System Library path
###
LD_LIBRARY_PATH=$LD_LIBRARY_PATH\
:/lib64/\
:/usr/lib64/\
:/lib/\
:/usr/lib/

export LD_LIBRARY_PATH

###################################################################

