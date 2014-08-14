#!/bin/bash

##############################################################################
## COMPLETE LABSIM Development Environment config							##	
##																			##
## Ce fichier est inclu par le .bashrc lors de l'ouverture d'un terminal	##
##																			##
## 07/02/12 - Kinani Nawfel													##
##############################################################################

# La chaine d'information sur l'environment courant
export DEV_CURRENT_DIST="Complete LABSIM Development Environment config"
export DEV_CURRENT_ID=0x02
export DEVTK_ROOT=/home/$(whoami)/dev/DEV-TK/

# Global environment mapping
source $DEVTK_ROOT/script/linux/package/global.conf.sh

# Progiciels specific environment mapping
source $DEVTK_ROOT/script/linux/package/progiciels.conf.sh

# HLA environment mapping
source $DEVTK_ROOT/script/linux/package/hla.conf.sh

# DDS environment mapping
source $DEVTK_ROOT/script/linux/package/dds.conf.sh

# LABSIM environment mapping
source $DEVTK_ROOT/script/linux/package/labsim_common.conf.sh
source $DEVTK_ROOT/script/linux/package/labsim_colosse.conf.sh
source $DEVTK_ROOT/script/linux/package/labsim_titans.conf.sh
source $DEVTK_ROOT/script/linux/package/labsim_contract.conf.sh

# == EOF
