#!/bin/bash

#######################
# Administrator Development Environment config
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
export DEV_CURRENT_DIST="Administrator Development Environment config"

###
# Developpement ToolKit Root Path
###
DEVTK_ROOT=~/dev/ELIPSTK/${DEV_SUBDIR}

###
# Global environment mapping
###
. ${DEVTK_ROOT}/etc/global.conf.sh

###
# Progiciels specific environment mapping
###
. ${DEVTK_ROOT}/etc/progiciels.conf.sh

###
# Project specific environment mapping
###
. ${DEVTK_ROOT}/etc/dev.conf.sh

#######################
