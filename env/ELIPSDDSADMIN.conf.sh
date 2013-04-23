#!/bin/bash

#######################
# ELIPS DDS Admin Environment config
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
export ELIPS_RELATIVE="../.."
# Le path relatif a chaque sous-projet (!! pas de slash de début et de fin)
export ELIPS_SUBDIR="trunk"
# La chaine d'information de l'environment courant
export ELIPS_CURRENT_DIST="ELIPS DDS Administrator Environment config"

###
# Global environment mapping
###
. "/home/$(whoami)/dev/ELIPSTK/${ELIPS_SUBDIR}/etc/global.conf.sh"

###
# DDS Specific environment mapping
###
. "/home/$(whoami)/dev/ELIPSTK/${ELIPS_SUBDIR}/etc/dds.conf.sh"

#######################
