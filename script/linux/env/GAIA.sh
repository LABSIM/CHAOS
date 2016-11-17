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

declare GAIA_DEV_DIST=""
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

##############################################################################
## Magic Section ! Cleanup and more ..										##
##############################################################################

# colored man -> https://gist.github.com/cocoalabs/2fb7dc2199b0d4bf160364b8e557eb66 :) 

man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
		man "$@"
}

# http://unix.stackexchange.com/questions/40749/remove-duplicate-path-entries-with-awk-command ... What else ?...

if [ -n "$PATH" ]; then
	old_PATH=$PATH:; PATH=
	while [ -n "$old_PATH" ]; do
		x=${old_PATH%%:*}        # the first remaining entry
		case $PATH: in
			*:"$x":*) ;;         # already there
			*) PATH=$PATH:$x;;   # not there yet
		esac
		old_PATH=${old_PATH#*:}
	done
	PATH=${PATH#:}
	unset old_PATH x
fi

if [ -n "$LD_LIBRARY_PATH" ]; then
	old_LD_LIBRARY_PATH=$LD_LIBRARY_PATH:; LD_LIBRARY_PATH=
	while [ -n "$old_LD_LIBRARY_PATH" ]; do
		x=${old_LD_LIBRARY_PATH%%:*}        			# the first remaining entry
		case $LD_LIBRARY_PATH: in
			*:"$x":*) ;;         						# already there
			*) LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$x;;  	# not there yet
		esac
		old_LD_LIBRARY_PATH=${old_LD_LIBRARY_PATH#*:}
	done
	LD_LIBRARY_PATH=${LD_LIBRARY_PATH#:}
	unset old_LD_LIBRARY_PATH x
fi

if [ -n "$CPATH" ]; then
	old_CPATH=$CPATH:; CPATH=
	while [ -n "$old_CPATH" ]; do
		x=${old_CPATH%%:*}        	# the first remaining entry
		case $CPATH: in
			*:"$x":*) ;;         	# already there
			*) CPATH=$CPATH:$x;;   	# not there yet
		esac
		old_CPATH=${old_CPATH#*:}
	done
	CPATH=${CPATH#:}
	unset old_CPATH x
fi

# == EOF
