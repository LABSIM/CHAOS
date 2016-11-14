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

if [ -d "$COLOSSES_HOME/GRT" ]; then

	GRT_ROOT=$COLOSSES_HOME/GRT
	GRT_INCLUDEDIR=$GRT_ROOT/include
	GRT_LIBRARYDIR=$GRT_ROOT/lib
	GRT_BINARYDIR=$GRT_ROOT/bin
	
	export GRT_ROOT GRT_INCLUDEDIR GRT_LIBRARYDIR GRT_BINARYDIR
	
	PATH=$PATH:$GRT_BINARYDIR
	LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$GRT_LIBRARYDIR
	
	GAIA_DEV_DIST="$GAIA_DEV_DIST\n\t|\t* GRT"
	
fi

# == MocapOptiTrack

if [ -d "$COLOSSES_HOME/MocapOptiTrack" ]; then
	
	MOCAPOPTITRACK_ROOT=$COLOSSES_HOME/MocapOptiTrack
	MOCAPOPTITRACK_INCLUDEDIR=$MOCAPOPTITRACK_ROOT/include
	MOCAPOPTITRACK_LIBRARYDIR=$MOCAPOPTITRACK_ROOT/lib
	MOCAPOPTITRACK_BINARYDIR=$MOCAPOPTITRACK_ROOT/bin
	
	export MOCAPOPTITRACK_ROOT MOCAPOPTITRACK_INCLUDEDIR MOCAPOPTITRACK_LIBRARYDIR MOCAPOPTITRACK_BINARYDIR
	
	PATH=$PATH:$MOCAPOPTITRACK_BINARYDIR
	LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MOCAPOPTITRACK_LIBRARYDIR
	
	GAIA_DEV_DIST="$GAIA_DEV_DIST\n\t|\t* MocapOptiTrack"
	
fi
	
# == LatencyModule

if [ -d "$COLOSSES_HOME/LatencyModule" ]; then

	LATENCYMODULE_ROOT=$COLOSSES_HOME/LatencyModule
	LATENCYMODULE_INCLUDEDIR=$LATENCYMODULE_ROOT/include
	LATENCYMODULE_LIBRARYDIR=$LATENCYMODULE_ROOT/lib
	LATENCYMODULE_BINARYDIR=$LATENCYMODULE_ROOT/bin
	
	export LATENCYMODULE_ROOT LATENCYMODULE_INCLUDEDIR LATENCYMODULE_LIBRARYDIR LATENCYMODULE_BINARYDIR
	
	PATH=$PATH:$LATENCYMODULE_BINARYDIR
	LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$LATENCYMODULE_LIBRARYDIR
	
	GAIA_DEV_DIST="$GAIA_DEV_DIST\n\t|\t* LatencyModule"
	
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

