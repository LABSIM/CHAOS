#!/bin/bash

######################################################################
## LABSIM Developpement environment config							##
##																	##
## Ce fichier contient l'ensemble des definitions					##
## pour les projets de Colosses en cours de developpement			##
##																	##
## 07/02/12 - Kinani Nawfel											##
######################################################################

COLOSSES_HOME=$DEV_HOME/Colosses

export COLOSSES_HOME

# ================================================================= #
# 								Colosses   							#
# ================================================================= #
# 																	#
# Contient les configurations pour les differents Modeles colosse 	#
# 																	#
# ================================================================= #

# == GRT

GRT_ROOT=$COLOSSES_HOME/GRT
GRT_INCLUDEDIR=$GRT_ROOT/include
GRT_LIBRARYDIR=$GRT_ROOT/lib
GRT_BINARYDIR=$GRT_ROOT/bin

export GRT_ROOT GRT_INCLUDEDIR GRT_LIBRARYDIR GRT_BINARYDIR

# == MocapOptiTrack

MOCAPOPTITRACK_ROOT=$COLOSSES_HOME/MocapOptiTrack
MOCAPOPTITRACK_INCLUDEDIR=$MOCAPOPTITRACK_ROOT/include
MOCAPOPTITRACK_LIBRARYDIR=$MOCAPOPTITRACK_ROOT/lib
MOCAPOPTITRACK_BINARYDIR=$MOCAPOPTITRACK_ROOT/bin

export MOCAPOPTITRACK_ROOT MOCAPOPTITRACK_INCLUDEDIR MOCAPOPTITRACK_LIBRARYDIR MOCAPOPTITRACK_BINARYDIR

# == LatencyModule

LATENCYMODULE_ROOT=$COLOSSES_HOME/LatencyModule
LATENCYMODULE_INCLUDEDIR=$LATENCYMODULE_ROOT/include
LATENCYMODULE_LIBRARYDIR=$LATENCYMODULE_ROOT/lib
LATENCYMODULE_BINARYDIR=$LATENCYMODULE_ROOT/bin

export LATENCYMODULE_ROOT LATENCYMODULE_INCLUDEDIR LATENCYMODULE_LIBRARYDIR LATENCYMODULE_BINARYDIR

# ================================================================= #
# 							Global Variable  						#
# ================================================================= #
# 																	#
# Configure les variables globales pour assurer un 					#
# fonctionnement correct 											#
# 																	#
# ================================================================= #

PATH=$PATH\
:$GRT_BINARYDIR

LD_LIBRARY_PATH=$LD_LIBRARY_PATH\
:$TEMPLATE_LIBRARYDIR\
:$GRT_LIBRARYDIR

export PATH LD_LIBRARY_PATH

