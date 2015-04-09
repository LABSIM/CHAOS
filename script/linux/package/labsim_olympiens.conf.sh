#!/bin/bash

######################################################################
## LABSIM Developpement environment config							##
##																	##
## Ce fichier contient l'ensemble des definitions					##
## pour les projets Olympiens en cours de developpement				##
##																	##
## 07/02/12 - Kinani Nawfel											##
######################################################################

# BASE
OLYMPIENS_HOME=$DEV_HOME/Olympiens

export OLYMPIENS_HOME

# ================================================================= #
# 						Olympiens codes 							#
# ================================================================= #
#																	#
# Contient les configurations pour les differents codes Olympiens :	#
# 																	#
# ================================================================= #

# == HEPHAISTOS

HEPHAISTOS_ROOT=$OLYMPIENS_HOME/HEPHAISTOS
HEPHAISTOS_INCLUDEDIR=$HEPHAISTOS_ROOT/include
HEPHAISTOS_LIBRARYDIR=$HEPHAISTOS_ROOT/lib
HEPHAISTOS_BINARYDIR=$HEPHAISTOS_ROOT/bin

export HEPHAISTOS_ROOT HEPHAISTOS_INCLUDEDIR HEPHAISTOS_LIBRARYDIR HEPHAISTOS_BINARYDIR

# ================================================================= #
# 							Global Variable  						#
# ================================================================= #
# 																	#
# Configure les variables globales pour assurer un 					#
# fonctionnement correct 											#
# 																	#
# ================================================================= #

PATH=$PATH\
:$HEPHAISTOS_BINARYDIR

LD_LIBRARY_PATH=$LD_LIBRARY_PATH\
:$HEPHAISTOS_LIBRARYDIR

export PATH LD_LIBRARY_PATH

