#!/bin/bash

######################################################################
## LABSIM Developpement environment config							##
##																	##
## Ce fichier contient l'ensemble des definitions					##
## pour les projets Titans en cours de developpement				##
##																	##
## 07/02/12 - Kinani Nawfel											##
######################################################################

# BASE
TITANS_HOME=$DEV_HOME/Titans

export TITANS_HOME

# ================================================================= #
# 							Titans codes 							#
# ================================================================= #
#																	#
# Contient les configurations pour les differents codes Titans :	#
#	- RHEA 															# 
#	- OCEAN															#
#	- THETYS														#							
#	- KRONOSDDS 					 								#		
#	- KRONOSIDL 													#
# 																	#
# ================================================================= #

# == RHEA 

RHEA_ROOT=$TITANS_HOME/RHEA

export RHEA_ROOT

# alias 
function __internal_labsim_rhea() {
	echo -e "\n## BEGIN LABSIM ROUTINES\n" 									\
	&& time perl -I $RHEA_ROOT/etc/module $RHEA_ROOT/bin/v2/RHEA.pl "$@"	\
	&& echo -e "\n## END LABSIM ROUTINES\n"
} # __internal_labsim_rhea()

alias rhea="__internal_labsim_rhea"

# == OCEAN 

OCEAN_ROOT=$TITANS_HOME/OCEAN

export OCEAN_ROOT

# alias 
function __internal_labsim_ocean() {
	echo -e "\n## BEGIN LABSIM ROUTINES\n" 									\
	&& time perl -I $OCEAN_ROOT/etc/module $OCEAN_ROOT/bin/v1/OCEAN.pl "$@"	\
	&& echo -e "\n## END LABSIM ROUTINES\n"
} # __internal_labsim_ocean()

alias ocean="__internal_labsim_ocean"

# == THETYS

THETYS_ROOT=$TITANS_HOME/THETYS
THETYS_INCLUDEDIR=$THETYS_ROOT/include
THETYS_LIBRARYDIR=$THETYS_ROOT/lib
THETYS_BINARYDIR=$THETYS_ROOT/bin

export THETYS_ROOT THETYS_INCLUDEDIR THETYS_LIBRARYDIR THETYS_BINARYDIR

# == KRONOS-DDS 

KRONOSDDS_ROOT=$TITANS_HOME/KRONOS-DDS
KRONOSDDS_INCLUDEDIR=$KRONOSDDS_ROOT/include
KRONOSDDS_LIBRARYDIR=$KRONOSDDS_ROOT/lib
KRONOSDDS_BINARYDIR=$KRONOSDDS_ROOT/bin

export KRONOSDDS_ROOT KRONOSDDS_INCLUDEDIR KRONOSDDS_LIBRARYDIR KRONOSDDS_BINARYDIR

# == KRONOS-IDL

KRONOSIDL_ROOT=$KRONOSDDS_ROOT/idl
KRONOSIDL_INCLUDEDIR="$KRONOSIDL_ROOT/include $KRONOSIDL_ROOT/traits"
KRONOSIDL_LIBRARYDIR=$KRONOSDDS_LIBRARYDIR
KRONOSIDL_BINARYDIR=$KRONOSDDS_BINARYDIR

export KRONOSIDL_ROOT KRONOSIDL_INCLUDEDIR KRONOSIDL_LIBRARYDIR KRONOSIDL_BINARYDIR

# ================================================================= #
# 							Global Variable  						#
# ================================================================= #
# 																	#
# Configure les variables globales pour assurer un 					#
# fonctionnement correct 											#
# 																	#
# ================================================================= #

PATH=$PATH\
:$THETYS_BINARYDIR\
:$KRONOSDDS_BINARYDIR

LD_LIBRARY_PATH=$LD_LIBRARY_PATH\
:$THETYS_LIBRARYDIR\
:$KRONOSDDS_LIBRARYDIR\

export PATH LD_LIBRARY_PATH

