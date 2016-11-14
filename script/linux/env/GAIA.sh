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

##############################################################################
## Entry point to the LABSIM Ground Sofware Ecosystem						##
##############################################################################

# Absolute path to this script
SCRIPT=$(readlink -f "$BASH_SOURCE")

# Absolute path this script is in
SCRIPTPATH=$(dirname "$SCRIPT")

# export necessary variables
export GAIA_ROOT=$(readlink -f "$SCRIPTPATH/../../../")

declare GAIA_DEV_DIST
GAIA_DEV_DIST="$GAIA_DEV_DIST# ================================================================= #"
GAIA_DEV_DIST="$GAIA_DEV_DIST\n# GAIA : the LABSIM ground software ecosystem"
GAIA_DEV_DIST="$GAIA_DEV_DIST\n# ================================================================= #"
GAIA_DEV_DIST="$GAIA_DEV_DIST\n# Copyright (C) 2012-2016 Nawfel KINANI"
GAIA_DEV_DIST="$GAIA_DEV_DIST\n# This program comes with ABSOLUTELY NO WARRANTY;"
GAIA_DEV_DIST="$GAIA_DEV_DIST\n# This is free software, and you are welcome to redistribute it"
GAIA_DEV_DIST="$GAIA_DEV_DIST\n# under certain conditions;"
GAIA_DEV_DIST="$GAIA_DEV_DIST\n# ================================================================= #"
GAIA_DEV_DIST="$GAIA_DEV_DIST\n\n[GAIA]--"

# dynamically check DRI environment -> normally DRI config use "module", sooooo....
if hash module 2>/dev/null; then
	export GAIA_FOUND_DRI_HOST=1
	GAIA_DEV_DIST="$GAIA_DEV_DIST+--[ DRI host ]"
else
	GAIA_DEV_DIST="$GAIA_DEV_DIST+--[ LABSIM host ]"
fi

# settings
if [ -f "$GAIA_ROOT/script/linux/package/labsim_settings.conf.sh" ]; then
	source $GAIA_ROOT/script/linux/package/labsim_settings.conf.sh
else
	echo "[GAIA][settings] Erreur dans la configuration de votre environment de travail... Contactez les administrateurs: Christian S. ou Nawfel K."
fi

# versions
if [ -f "$GAIA_ROOT/script/linux/routine/versions.sh" ]; then
	source $GAIA_ROOT/script/linux/routine/versions.sh
else
	echo "[GAIA][versions] Erreur dans la configuration de votre environment de travail... Contactez les administrateurs: Christian S. ou Nawfel K."
fi

# External software
if [ -f "$GAIA_ROOT/script/linux/package/labsim_external.conf.sh" ]; then
	GAIA_DEV_DIST="$GAIA_DEV_DIST\n\t+--[ External ]"
	source $GAIA_ROOT/script/linux/package/labsim_external.conf.sh
else
	echo "[GAIA][external] Erreur dans la configuration de votre environment de travail... Contactez les administrateurs: Christian S. ou Nawfel K."
fi

# Common software
if [ -f "$GAIA_ROOT/script/linux/package/labsim_common.conf.sh" ]; then
	GAIA_DEV_DIST="$GAIA_DEV_DIST\n\t+--[ Common ]"
	source $GAIA_ROOT/script/linux/package/labsim_common.conf.sh
else
	echo "[GAIA][common] Erreur dans la configuration de votre environment de travail... Contactez les administrateurs: Christian S. ou Nawfel K."
fi

# Colosses software
if [ -d "$DEV_HOME/Colosses/" ]; then

	if [ -f "$GAIA_ROOT/script/linux/package/labsim_colosses.conf.sh" ]; then
		GAIA_DEV_DIST="$GAIA_DEV_DIST\n\t+--[ Colosses ]"
		source $GAIA_ROOT/script/linux/package/labsim_colosses.conf.sh
	else
		echo "[GAIA][colosses] Erreur dans la configuration de votre environment de travail... Contactez les administrateurs: Christian S. ou Nawfel K."
	fi

fi

# Olympiens software
if [ -d "$DEV_HOME/Olympiens" ]; then 
	
	if [ -f "$GAIA_ROOT/script/linux/package/labsim_olympiens.conf.sh" ]; then 
		GAIA_DEV_DIST="$GAIA_DEV_DIST\n\t+--[ Olympiens ]"
		source $GAIA_ROOT/script/linux/package/labsim_olympiens.conf.sh
	else
		echo "[GAIA][olympiens] Erreur dans la configuration de votre environment de travail... Contactez les administrateurs: Christian S. ou Nawfel K."
	fi
	
fi

# Titans software
if [ -d "$DEV_HOME/Titans" ]; then 

	if [ -f "$GAIA_ROOT/script/linux/package/labsim_titans.conf.sh" ]; then 
		GAIA_DEV_DIST="$GAIA_DEV_DIST\n\t+--[ Titans ]"
		source $GAIA_ROOT/script/linux/package/hla.conf.sh
		source $GAIA_ROOT/script/linux/package/dds.conf.sh
		source $GAIA_ROOT/script/linux/package/labsim_titans.conf.sh
	else
		echo "[GAIA][titans] Erreur dans la configuration de votre environment de travail... Contactez les administrateurs: Christian S. ou Nawfel K."
	fi

fi

# Contract software
if [ -d "$DEV_HOME/Contract" ]; then 
	
	if [ -f "$GAIA_ROOT/script/linux/package/labsim_contract.conf.sh" ]; then 
		GAIA_DEV_DIST="$GAIA_DEV_DIST\n\t+--[ Contract ]"
		source $GAIA_ROOT/script/linux/package/labsim_contract.conf.sh
	else
		echo "[GAIA][contract] Erreur dans la configuration de votre environment de travail... Contactez les administrateurs: Christian S. ou Nawfel K."
	fi
fi

GAIA_DEV_DIST="$GAIA_DEV_DIST\n\t+"

# == EOF
