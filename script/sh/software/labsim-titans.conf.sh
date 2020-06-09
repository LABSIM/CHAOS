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

# detail 
GAIA_ECOSYSTEM_DETAIL+="\n\t+--[ LABSIM : <Titans> ]"

# == RHEA 

if [ -d "${GAIA_DEV_HOME}/titans/RHEA" ]; then
	
	RHEA_ROOT=${GAIA_DEV_HOME}/titans/RHEA
	
	export RHEA_ROOT
	
	# alias 
	function __internal_labsim_rhea() {
		echo -e "\n## BEGIN LABSIM ROUTINES\n" \
		&& time perl -I $RHEA_ROOT/script/module $RHEA_ROOT/script/RHEA.pl "$@"	\
		&& echo -e "\n## END LABSIM ROUTINES\n"
	} # __internal_labsim_rhea()
	
	alias rhea="__internal_labsim_rhea"
	
	GAIA_ECOSYSTEM_DETAIL+="\n\t|\t* RHEA"
	
fi

# == OCEAN 

if [ -d "${GAIA_DEV_HOME}/titans/OCEAN" ]; then
	
	OCEAN_ROOT=${GAIA_DEV_HOME}/titans/OCEAN
	
	export OCEAN_ROOT
	
	# alias 
	function __internal_labsim_ocean() {
		echo -e "\n## BEGIN LABSIM ROUTINES\n" 									\
		&& time perl -I $OCEAN_ROOT/script/module $OCEAN_ROOT/script/OCEAN.pl "$@"	\
		&& echo -e "\n## END LABSIM ROUTINES\n"
	} # __internal_labsim_ocean()
	
	alias ocean="__internal_labsim_ocean"
	
	GAIA_ECOSYSTEM_DETAIL+="\n\t|\t* OCEAN"

fi

# == OURANOS

if [ -d "${GAIA_DEV_HOME}/titans/OURANOS" ]; then

	OURANOS_ROOT=${GAIA_DEV_HOME}/titans/OURANOS
	#OURANOS_INCLUDEDIR=$OURANOS_ROOT/include
	#OURANOS_LIBRARYDIR=$OURANOS_ROOT/lib
	#OURANOS_BINARYDIR=$OURANOS_ROOT/bin
	
	export OURANOS_ROOT
	#export OURANOS_ROOT OURANOS_INCLUDEDIR OURANOS_LIBRARYDIR OURANOS_BINARYDIR
	
	#PATH=$PATH:$OURANOS_BINARYDIR
	#LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$OURANOS_LIBRARYDIR
	
	GAIA_ECOSYSTEM_DETAIL+="\n\t|\t* OURANOS"

fi

# == THETYS

if [ -d "${GAIA_DEV_HOME}/titans/THETYS" ]; then

	THETYS_ROOT=${GAIA_DEV_HOME}/titans/THETYS
	#THETYS_INCLUDEDIR=$THETYS_ROOT/include
	#THETYS_LIBRARYDIR=$THETYS_ROOT/lib
	#THETYS_BINARYDIR=$THETYS_ROOT/bin
	
	export THETYS_ROOT
	#export THETYS_ROOT THETYS_INCLUDEDIR THETYS_LIBRARYDIR THETYS_BINARYDIR
	
	#PATH=$PATH:$THETYS_BINARYDIR
	#LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$THETYS_LIBRARYDIR
	
	GAIA_ECOSYSTEM_DETAIL+="\n\t|\t* THETYS"

fi

# == KRONOS-DDS 

if [ -d "${GAIA_DEV_HOME}/titans/KRONOS-DDS" ]; then
	
	KRONOS_ROOT=${GAIA_DEV_HOME}/titans/KRONOS
	#KRONOSDDS_INCLUDEDIR=$KRONOSDDS_ROOT/include
	#KRONOSDDS_LIBRARYDIR=$KRONOSDDS_ROOT/lib
	#KRONOSDDS_BINARYDIR=$KRONOSDDS_ROOT/bin
	
	export KRONOS_ROOT
	#export KRONOSDDS_ROOT KRONOSDDS_INCLUDEDIR KRONOSDDS_LIBRARYDIR KRONOSDDS_BINARYDIR
	
	#PATH=$PATH:$KRONOSDDS_BINARYDIR
	#LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$KRONOSDDS_LIBRARYDIR
	
	GAIA_ECOSYSTEM_DETAIL+="\n\t|\t* KRONOS"

fi

