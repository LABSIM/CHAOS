#!/bin/bash

#######################
# DDS Administrator Dev Environment config
#
# Ce fichier est inclu par le .bashrc lors de l'ouverture d'un terminal
#
# 07/02/12 - Kinani Nawfel
#######################

###
# File recovery
###

# Ces variables servent pour la construction des chemins relatif au types de l'environment de dev utilisé 
# -> type foo/src seulement ou foo/branch/src
export DEV_RELATIVE="../.."
export DEV_SUBDIR="trunk"

# La chaine d'information sur l'environment courant
export DEV_CURRENT_DIST="DDS Administrator Dev Environment config"

###
# Developpement ToolKit Root Path
###
DEVTK_ROOT=~/dev/DEV-TK/${DEV_SUBDIR}

###
# Global environment mapping
###
. ${DEVTK_ROOT}/script/linux/package/global.conf.sh

###
# Progiciels specific environment mapping
###
. ${DEVTK_ROOT}/script/linux/package/progiciels.conf.sh

###
# Project specific environment mapping
###
. ${DEVTK_ROOT}/script/linux/package/dev.conf.sh

###
# DDS Specific environment mapping
###
. ${DEVTK_ROOT}/script/linux/package/dds.conf.sh

#######################
