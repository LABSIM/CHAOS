#!/bin/bash

##############################################################################
## BASIC LABSIM Development Environment config								##	
##																			##
## Ce fichier est inclu par le .bashrc lors de l'ouverture d'un terminal	##
##																			##
## 07/02/12 - Kinani Nawfel													##
##############################################################################


# La chaine d'information sur l'environment courant
export DEV_CURRENT_DIST="Basic LABSIM Development Environment config"
export DEV_CURRENT_ID=0x01
export DEVTK_ROOT=/home/$(whoami)/dev/DEV-TK/

# Global environment mapping
source $DEVTK_ROOT/script/linux/package/global.conf.sh

# Progiciels specific environment mapping
source $DEVTK_ROOT/script/linux/package/progiciels.conf.sh

# LABSIM environment mapping
source $DEVTK_ROOT/script/linux/package/labsim_common.conf.sh

# == EOF
