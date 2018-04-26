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

if [ -d "$OLYMPIENS_HOME/HEPHAISTOS" ]; then
	
	HEPHAISTOS_ROOT=$OLYMPIENS_HOME/HEPHAISTOS
	HEPHAISTOS_INCLUDEDIR=$HEPHAISTOS_ROOT/include
	HEPHAISTOS_LIBRARYDIR=$HEPHAISTOS_ROOT/lib
	HEPHAISTOS_BINARYDIR=$HEPHAISTOS_ROOT/bin
	
	export HEPHAISTOS_ROOT HEPHAISTOS_INCLUDEDIR HEPHAISTOS_LIBRARYDIR HEPHAISTOS_BINARYDIR
	
	PATH=$PATH:$HEPHAISTOS_BINARYDIR
	LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HEPHAISTOS_LIBRARYDIR
	
	GAIA_DISTRIBUTION_DETAIL="$GAIA_DISTRIBUTION_DETAIL\n\t|\t* HEPHAISTOS"
	
fi

# ================================================================= #
# 							Global Variable  						#
# ================================================================= #
# 																	#
# Exporte les variables globales pour assurer un 					#
# fonctionnement correct 											#
# 																	#
# ================================================================= #

export PATH LD_LIBRARY_PATH

