#!/bin/bash

#
# GAIA : required LABSIM ground software ecosystem
# Copyright (C) 2012-2016  Nawfel KINANI
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; see the file COPYING.
# If not, see <http://www.gnu.org/licenses/>.
#

######################################################################
## LABSIM Developpement environment config							##
##																	##
## Ce fichier contient l'ensemble des definitions					##
## pour les contrats en cours de developpement						##
##																	##
## 07/02/12 - Kinani Nawfel											##
######################################################################

# BASE
CONTRACT_HOME=$DEV_HOME/Contract

export CONTRACT_HOME

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

if [ -d "$CONTRACT_HOME/SAMCOH" ]; then
	
	SAMCOH_ROOT=$CONTRACT_HOME/SAMCOH
	SAMCOH_INCLUDEDIR=$SAMCOH_ROOT/include
	SAMCOH_LIBRARYDIR=$SAMCOH_ROOT/lib
	SAMCOH_BINARYDIR=$SAMCOH_ROOT/bin
	
	export SAMCOH_ROOT SAMCOH_INCLUDEDIR SAMCOH_LIBRARYDIR SAMCOH_BINARYDIR

	PATH=$PATH:$SAMCOH_BINARYDIR
	LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$SAMCOH_LIBRARYDIR
	
	GAIA_DISTRIBUTION_DETAIL="$GAIA_DISTRIBUTION_DETAIL\n\t|\t* SAMCOH"

fi

# == CARNOT

if [ -d "$CONTRACT_HOME/CARNOT" ]; then
	
	CARNOT_ROOT=$CONTRACT_HOME/CARNOT
	CARNOT_INCLUDEDIR=$CARNOT_ROOT/include
	CARNOT_LIBRARYDIR=$CARNOT_ROOT/lib
	CARNOT_BINARYDIR=$CARNOT_ROOT/bin
	
	export CARNOT_ROOT CARNOT_INCLUDEDIR CARNOT_LIBRARYDIR CARNOT_BINARYDIR
	
	PATH=$PATH:$CARNOT_BINARYDIR
	LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CARNOT_LIBRARYDIR
	
	GAIA_DISTRIBUTION_DETAIL="$GAIA_DISTRIBUTION_DETAIL\n\t|\t* CARNOT"

fi

# ================================================================= #
# 							Global Variable  						#
# ================================================================= #
# 																	#
# Configure les variables globales pour assurer un 					#
# fonctionnement correct 											#
# 																	#
# ================================================================= #

export PATH LD_LIBRARY_PATH

