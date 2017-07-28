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

#######################
# global environment config
#
# Ce fichier defini les variables de bases 
#
# 07/02/12 - Kinani Nawfel
#######################

# configuration DRI ?
if [ -z ${GAIA_FOUND_DRI_HOST+x} ]; then 
	# LABSIM HOST
	NEED_DRI_BYPASS_HACK=0
else 
	# DRI HOST
	NEED_DRI_BYPASS_HACK=1
fi

# if bypassing labsim variable is on then load required DRI module
if [ $NEED_DRI_BYPASS_HACK -eq 1 ]; then
	module add gcc/5.2
	module add gdb/7.9.1
	module add subversion/1.7.6
	module unload texlive/2014 intel/cce/11.1.064 intel/cmkle/11.1.064 intel/fce/11.1.064 intel/idbe/11.1.064 eclipse/3.6.1 cmake/3.2.2
fi

###################################################################
# Home path
###

if [ $NEED_DRI_BYPASS_HACK -eq 1 ]; then
	# Use local directory for compilation performance
	DEV_HOME=/tmp_user/$(hostname)/$(whoami)/dev
	CODES_HOME=/tmp_user/$(hostname)/$(whoami)/CODES
else
	# Use home directory - default
	DEV_HOME=$(eval echo "~$(whoami)")/dev
	CODES_HOME=$(eval echo "~$(whoami)")/CODES
fi

PRO_HOME=$(eval echo "~$(whoami)")/Progiciels
BDD_HOME=/data/bdd

export PRO_HOME CODES_HOME BDD_HOME DEV_HOME IDE_HOME

###
# funtions
###

function __internal_labsim_environment() {
	echo -e "\n## BEGIN LABSIM ROUTINES\n" 	\
	&& echo -e ${GAIA_DEV_DIST} 			\
	&& echo -e "\n## END LABSIM ROUTINES\n"
} # __internal_labsim_environment()

###
# long alias
###
alias gaia="__internal_labsim_environment"

###
# short alias
###
alias le="labsim_env"

###################################################################
# Other
###

# On active le traitement des commandes tierces avec xhost
xhost + > /dev/null 2>&1

###################################################################
# Default System Library path
###
LD_LIBRARY_PATH=$LD_LIBRARY_PATH\
:/lib64/\
:/usr/lib64/\
:/lib/\
:/usr/lib/

export LD_LIBRARY_PATH

###################################################################
# Default proxy

export http_proxy=http://proxy.onera:80
export https_proxy=http://proxy.onera:80

###################################################################

