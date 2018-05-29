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
GAIA_ECOSYSTEM_DETAIL="$GAIA_ECOSYSTEM_DETAIL\n\t+--[ LABSIM : <Common> ]"

######################################################################
## LABSIM Developpement environment config							##
##																	##
## Ce fichier contient l'ensemble des definitions					##
## pour les projets communs en cours de developpement				##
##																	##
## 07/02/12 - Kinani Nawfel											##
######################################################################

# ================================================================= #
# 							Common codes root 						#
# ================================================================= #
# 																	#
# Contient les configurations pour les differents codes communs : 	#
#	- Utilities 													#
#	- propTree 														#
#	- HUD 															#
#	- VESA 															#
#	- ELIPS 														#
#	- ELIPS-TK 														#
#	- ELIPS-DEMO 													#
#	- VISUEL PA 													#
# 																	#
# ================================================================= #

# == UTILITIES

if [ -d "$DEV_HOME/Utilities" ]; then
	
	UTILITIES_ROOT=$DEV_HOME/Utilities
	UTILITIES_INCLUDEDIR=$UTILITIES_ROOT/include
	UTILITIES_LIBRARYDIR=$UTILITIES_ROOT/lib
	
	export UTILITIES_ROOT UTILITIES_INCLUDEDIR UTILITIES_LIBRARYDIR
	
	LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$UTILITIES_LIBRARYDIR
	
	GAIA_ECOSYSTEM_DETAIL="$GAIA_ECOSYSTEM_DETAIL\n\t|\t* Utilities"

fi

# == PROPTREE 

if [ -d "$DEV_HOME/propTree" ]; then

	PROPTREE_ROOT=$DEV_HOME/propTree
	PROPTREE_INCLUDEDIR=$PROPTREE_ROOT/include
	PROPTREE_LIBRARYDIR=$PROPTREE_ROOT/lib
	
	export PROPTREE_ROOT PROPTREE_INCLUDEDIR PROPTREE_LIBRARYDIR
	
	LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PROPTREE_LIBRARYDIR
	
	GAIA_ECOSYSTEM_DETAIL="$GAIA_ECOSYSTEM_DETAIL\n\t|\t* propTree"

fi

# == HUD 

if [ -d "$DEV_HOME/HUD" ]; then
	
	HUD_ROOT=$DEV_HOME/HUD
	HUD_INCLUDEDIR=$HUD_ROOT/include
	HUD_LIBRARYDIR=$HUD_ROOT/lib
	
	export HUD_ROOT HUD_INCLUDEDIR HUD_LIBRARYDIR

	LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HUD_LIBRARYDIR
	
	GAIA_ECOSYSTEM_DETAIL="$GAIA_ECOSYSTEM_DETAIL\n\t|\t* HUD"

fi

# == VESA 

if [ -d "$DEV_HOME/VESA" ]; then

	VESA_ROOT=$DEV_HOME/VESA
	VESA_INCLUDEDIR=$VESA_ROOT/include
	VESA_LIBRARYDIR=$VESA_ROOT/lib
	VESA_BINARYDIR=$VESA_ROOT/bin
	
	export VESA_ROOT VESA_INCLUDEDIR VESA_LIBRARYDIR VESA_BINARYDIR
	
	PATH=$PATH:$VESA_BINARYDIR
	LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$VESA_LIBRARYDIR
	
	GAIA_ECOSYSTEM_DETAIL="$GAIA_ECOSYSTEM_DETAIL\n\t|\t* VESA"
	
fi

# == ELIPS 

if [ -d "$DEV_HOME/ELIPS" ]; then

	ELIPS_ROOT=$DEV_HOME/ELIPS
	ELIPS_INCLUDEDIR=$(find -L ${ELIPS_ROOT}/include -type d | grep -v svn | grep -v VTB_QT)
	ELIPS_INCLUDEDIR=$(echo -e "${ELIPS_ROOT}/build\n${ELIPS_INCLUDEDIR}" | tr '\n' ';')
	ELIPS_LIBRARYDIR=$ELIPS_ROOT/lib
	ELIPS_BINARYDIR=$ELIPS_ROOT/bin
	
	ELIPSHOME=$ELIPS_ROOT	# backward compatibility
	LC_NUMERIC=en_US
	
	export ELIPS_ROOT ELIPS_INCLUDEDIR ELIPS_LIBRARYDIR ELIPS_BINARYDIR ELIPSHOME LC_NUMERIC
	
	alias menage="$ELIPS_ROOT/etc/menage.sh"
	alias cleanipc="$ELIPS_ROOT/etc/cleanipc.sh"
	alias ELIPSutil="konqueror $ELIPS_ROOT/doc/html/PDF/ELIPS-RT2005_utilisateur.pdf"
	alias VENUShelp="konqueror $ELIPS_ROOT/doc/html/PDF/VENUS-RT2005.pdf"
	alias ELIPShelp="konqueror $ELIPS_ROOT/doc/html/index.html"
	
	PATH=$PATH:$ELIPS_BINARYDIR
	LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ELIPS_LIBRARYDIR
	
	GAIA_ECOSYSTEM_DETAIL="$GAIA_ECOSYSTEM_DETAIL\n\t|\t* ELIPS"

fi

# == ELIPS-TK

if [ -d "$DEV_HOME/ELIPS-TK" ]; then

	ELIPSTK_ROOT=$DEV_HOME/ELIPS-TK
	ELIPSTK_INCLUDEDIR=$ELIPSTK_ROOT/include
	ELIPSTK_LIBRARYDIR=$ELIPSTK_ROOT/lib
	ELIPSTK_BINARYDIR=$ELIPSTK_ROOT/bin
	
	export ELIPSTK_ROOT ELIPSTK_INCLUDEDIR ELIPSTK_LIBRARYDIR ELIPSTK_BINARYDIR
	
	GAIA_ECOSYSTEM_DETAIL="$GAIA_ECOSYSTEM_DETAIL\n\t|\t* ELIPS-TK"

fi

# == ELIPS-DEMO

if [ -d "$DEV_HOME/ELIPS-DEMO" ]; then

	ELIPSDEMO_ROOT=$DEV_HOME/ELIPS-DEMO
	
	export ELIPSDEMO_ROOT
	
	GAIA_ECOSYSTEM_DETAIL="$GAIA_ECOSYSTEM_DETAIL\n\t|\t* ELIPS-DEMO"

fi

# == VISUEL PA 

if [ -d "$DEV_HOME/IMAGE_PA" ]; then

	IMAGE_PA_PATH=$BDD_HOME/IMAGE_PA
	
	export IMAGE_PA_PATH
	
	GAIA_ECOSYSTEM_DETAIL="$GAIA_ECOSYSTEM_DETAIL\n\t|\t* IMAGE_PA"

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

