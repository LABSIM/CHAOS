#!/bin/bash

######################################################################
## LABSIM Developpement environment config							##
##																	##
## Ce fichier contient l'ensemble des definitions					##
## pour les contrats en cours de developpement						##
##																	##
## 07/02/12 - Kinani Nawfel											##
######################################################################


# ================================================================= #
# 						Contract codes root 						#
# ================================================================= #
# 																	#
# Contient les configurations pour les differents codes ponctuels : #
#	- SAMCOH 														#
#	- CARNOT 														#
# 																	#
# ================================================================= #

# == SAMCOH

SAMCOH_ROOT=$DEV_HOME/SAMCOH
SAMCOH_INCLUDEDIR=$SAMCOH_ROOT/include
SAMCOH_LIBRARYDIR=$SAMCOH_ROOT/lib
SAMCOH_BINARYDIR=$SAMCOH_ROOT/bin

export SAMCOH_ROOT SAMCOH_INCLUDEDIR SAMCOH_LIBRARYDIR SAMCOH_BINARYDIR

# == CARNOT

CARNOT_ROOT=$DEV_HOME/CARNOT
CARNOT_INCLUDEDIR=$CARNOT_ROOT/include
CARNOT_LIBRARYDIR=$CARNOT_ROOT/lib
CARNOT_BINARYDIR=$CARNOT_ROOT/bin

export CARNOT_ROOT CARNOT_INCLUDEDIR CARNOT_LIBRARYDIR CARNOT_BINARYDIR

# ================================================================= #
# 							Global Variable  						#
# ================================================================= #
# 																	#
# Configure les variables globales pour assurer un 					#
# fonctionnement correct 											#
# 																	#
# ================================================================= #

PATH=$PATH\
:$CARNOT_BINARYDIR\
:$SAMCOH_BINARYDIR

LD_LIBRARY_PATH=$LD_LIBRARY_PATH\
:$CARNOT_LIBRARYDIR\
:$SAMCOH_LIBRARYDIR

export PATH LD_LIBRARY_PATH

