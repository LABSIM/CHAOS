#!/bin/bash

#######################
# global environment config
#
# Ce fichier defini les variables de bases 
#
# 07/02/12 - Kinani Nawfel
#######################

# configuration DRI ?
if [ -z ${LABSIM_DRI_HOST_ADMIN+x} ]; then 
	# LABSIM HOST
	NEED_DRI_BYPASS_HACK=0
else 
	# DRI HOST
	NEED_DRI_BYPASS_HACK=1
fi

# if bypassing labsim variable is on then load required DRI module
if [ $NEED_DRI_BYPASS_HACK -eq 1 ]; then
	module add gcc/5.2
	module add subversion/1.7.6
	module unload intel/cce/11.1.064 intel/cmkle/11.1.064 intel/fce/11.1.064 intel/idbe/11.1.064
fi

###################################################################
# Home path
###
DEV_HOME=$(eval echo "~$(whoami)")/Dev
PRO_HOME=$(eval echo "~$(whoami)")/Progiciels
CODES_HOME=$(eval echo "~$(whoami)")/CODES
BDD_HOME=/data/bdd

export PRO_HOME CODES_HOME BDD_HOME DEV_HOME IDE_HOME

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
	&& time sh $DEVTK_ROOT/script/linux/switch_environment.sh "$@"	\
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

