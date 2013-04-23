#!/bin/bash

#######################
# ELIPS Dev Environment config
#
# Ce fichier est inclu depuis /etc/profile au demarrage de la machine
# ou alors par le fichier .bashrc lors de l'ouverture d'un terminal
#
# 07/02/12 - Kinani Nawfel
#######################

###
# File recovery
###
# Ces variables servent pour la construction des chemins relatif au types de l'environment de dev utilisé -> type foo/src seulement ou foo/branch/src
# Le path relatif a ELIPSHOME pour recuperer /dev/ (!! pas de slash de début et de fin)
export ELIPS_RELATIVE=".."
# Le path relatif a chaque sous-projet (!! pas de slash de début et de fin)
export ELIPS_SUBDIR="."
# La chaine d'information de l'environment courant
export ELIPS_CURRENT_DIST="ELIPS Dev Environment config"

###
# Global environment mapping
###
source "~/dev/ELIPSTK/${ELIPS_SUBDIR}/env/global.conf.sh"

#######################