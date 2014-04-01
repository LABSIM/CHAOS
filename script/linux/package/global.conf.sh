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

DEV_HOME=/home/$(whoami)/dev
IDE_HOME=/home/$(whoami)/IDE
PRO_HOME=/home/$(whoami)/Progiciels
CODES_HOME=/home/$(whoami)/CODES
BDD_HOME=/data/bdd

export PRO_HOME CODES_HOME BDD_HOME DEV_HOME IDE_HOME

###
# Informations
###
function whichDevTK()
{
	echo "=========================================================================="
 	echo " Environment de dev courant : ${DEV_CURRENT_DIST}"
	echo "=========================================================================="
}

###
# Switch
###
if [ -f "${DEV_HOME}/DEV-TK/${DEV_SUBDIR}/script/linux/switchenv.sh" ]; then 
	alias switchenv="sh ${DEV_HOME}/DEV-TK/${DEV_SUBDIR}/script/linux/switchenv.sh"
fi


###################################################################
# Other
###

# On active le traitement des commandes tierces avec xhost
xhost + > /dev/null 2>&1

###################################################################
# Versions deployment
###
if [ -f "${DEVTK_ROOT}/conf/versions.sh" ]; then 
	. ${DEVTK_ROOT}/conf/versions.sh
else
	echo "Erreur dans la configuration de votre environment de travail... Contactez les administrateurs: Christian S. ou Nawfel K."
fi

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
