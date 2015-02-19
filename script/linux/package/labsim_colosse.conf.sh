#!/bin/bash

######################################################################
## LABSIM Developpement environment config							##
##																	##
## Ce fichier contient l'ensemble des definitions					##
## pour les projets de Modeles Colosse en cours de developpement	##
##																	##
## 07/02/12 - Kinani Nawfel											##
######################################################################

COLOSSE_HOME=$DEV_HOME/Colosse

export COLOSSE_HOME

# ================================================================= #
# 								Colosse   							#
# ================================================================= #
# 																	#
# Contient les configurations pour les differents Modeles colosse :	#
# 																	#
# ================================================================= #

# == TEMPLATE MODEL

TEMPLATE_ROOT=$COLOSSE_HOME/Template
TEMPLATE_INCLUDEDIR=$TEMPLATE_ROOT/include
TEMPLATE_LIBRARYDIR=$TEMPLATE_ROOT/lib

export TEMPLATE_ROOT TEMPLATE_INCLUDEDIR TEMPLATE_LIBRARYDIR

# == GRT

GRT_ROOT=$COLOSSE_HOME/GRT
GRT_INCLUDEDIR=$GRT_ROOT/include
GRT_LIBRARYDIR=$GRT_ROOT/lib
GRT_BINARYDIR=$GRT_ROOT/bin

export GRT_ROOT GRT_INCLUDEDIR GRT_LIBRARYDIR GRT_BINARYDIR

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

