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

#################################################
# settings.conf.sh
#
# Ce fichier defini les variables de bases 
#
# 07/02/12 - Kinani Nawfel
#

###################################################################
# Module
###
if [ "${GAIA_FOUND_DSI_HOST}" = true ]; then

	#
	# Default development environment
	#
	
	#
	# ADD --> will be unloaded if by corresponding third_party dependancies
	#
	module add subversion/1.7.6
	module add gcc/5.2
	module add gdb/7.9.1
	module add cmake/3.2.2
	module add qt-framework/4.8.5/gnu
	module add eclipse/4.6.0M3

	#
	# UNLOAD
	#
	module unload texlive/2014
	module unload intel/cce/11.1.064
	module unload intel/cmkle/11.1.064
	module unload intel/fce/11.1.064
	module unload intel/idbe/11.1.064
	module unload eclipse/3.6.1

fi

###################################################################
# Directories
###

if [ "${GAIA_FOUND_DSI_HOST}" = true ]; then

	# Use local directory for compilation performance
	GAIA_DEV_HOME="${GAIA_HOME_DSI_HINT}/dev"
	GAIA_THIRD_PARTY_HOME="${GAIA_HOME_DSI_HINT}/third_party"

else

	# Use home directory - default
	GAIA_DEV_HOME="$(eval echo "~$(whoami)")/dev"
	GAIA_THIRD_PARTY_HOME="$(eval echo "~$(whoami)")/third_party"

fi

#GAIA_BDD_HOME=/data/bdd
#GAIA_CONTRACT_HOME=$GAIA_DEV_HOME/Contract
GAIA_COLOSSES_HOME=$GAIA_DEV_HOME/Colosses
GAIA_OLYMPIENS_HOME=$GAIA_DEV_HOME/Olympiens
GAIA_TITANS_HOME=$GAIA_DEV_HOME/Titans

export GAIA_THIRD_PARTY_HOME GAIA_DEV_HOME GAIA_COLOSSES_HOME GAIA_OLYMPIENS_HOME GAIA_TITANS_HOME # BDD_HOME GAIA_CONTRACT_HOME 

###################################################################
# Other export ...
###

# On active le traitement des commandes tierces avec xhost 
# TODO ?? remove this motherfucking line ??
#xhost + > /dev/null 2>&1

# on corrige la "superbe" instalation DSI...
export PATH=$PATH:/usr/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/lib64/:/usr/lib64/:/lib/:/usr/lib/
export CPATH=/usr/include

# --> [ https://gcc.gnu.org/onlinedocs/cpp/Environment-Variables.html ]
#export C_INCLUDE_PATH=$CPATH
#export CPLUS_INCLUDE_PATH=$CPATH

# Default ONERA's proxy... meme ca... 
export http_proxy=http://proxy.onera:80
export https_proxy=http://proxy.onera:80

# link to --> [ https://sourceforge.net/p/autogen/bugs/183/ ]
export PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1
export PKG_CONFIG_ALLOW_SYSTEM_LIBS=1

###################################################################

return 0
# == EOF
