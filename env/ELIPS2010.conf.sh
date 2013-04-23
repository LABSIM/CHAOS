#!/bin/bash

#######################
# ELIPS 2010 Environment config
#
# Ce fichier est inclu depuis /etc/profile au demarrage de la machine
# ou alors par le fichier .bashrc lors de l'ouverture d'un terminal
#
# 07/02/12 - Kinani Nawfel
#######################

# La chaine d'information de l'environment courant
export ELIPS_CURRENT_DIST="ELIPS 2010 Environment config"

###
# ELIPS Dir
###
source "/home/elips/ELIPS2010/gener.macro"

###
# Global environment mapping
###
source "/home/elips/dev/ELIPSTK/env/global_env_conf"

#######################
