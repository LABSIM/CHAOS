#!/usr/bin/env bash

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
## Entry point to the LABSIM Ground Sofware Ecosystem			    ##
##############################################################################

# get the source dir --> [ https://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within ]
pushd . > /dev/null
SCRIPT_PATH="${BASH_SOURCE[0]}"
if ([ -h "${SCRIPT_PATH}" ]); then
  while([ -h "${SCRIPT_PATH}" ]); do cd `dirname "$SCRIPT_PATH"`; 
  SCRIPT_PATH=`readlink "${SCRIPT_PATH}"`; done
fi
cd `dirname ${SCRIPT_PATH}` > /dev/null
SCRIPT_PATH=`pwd`;
popd  > /dev/null

# GAIA root dir
export GAIA_ROOT="$( cd "$(dirname "$SCRIPT_PATH/../../..")" ; pwd )"

# Distribution detail
export GAIA_ECOSYSTEM_DETAIL=""

# clean ASAP
unset SCRIPT_PATH

# configure
source "${GAIA_ROOT}/script/sh/function/configure-env.conf.sh"
source "${GAIA_ROOT}/script/sh/function/configure-third_party.conf.sh"

# initialize dist detail
GAIA_ECOSYSTEM_DETAIL+="\n# ================================================================= #"
GAIA_ECOSYSTEM_DETAIL+="\n# GAIA : the LABSIM ground software ecosystem"
GAIA_ECOSYSTEM_DETAIL+="\n# ================================================================= #"
GAIA_ECOSYSTEM_DETAIL+="\n# Copyright (C) 2012-2016 Nawfel KINANI"
GAIA_ECOSYSTEM_DETAIL+="\n# This program comes with ABSOLUTELY NO WARRANTY;"
GAIA_ECOSYSTEM_DETAIL+="\n# This is free software, and you are welcome to redistribute it"
GAIA_ECOSYSTEM_DETAIL+="\n# under certain conditions;"
GAIA_ECOSYSTEM_DETAIL+="\n# ================================================================= #"
GAIA_ECOSYSTEM_DETAIL+="\n\n[GAIA]--+--[ Host ]"

###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
#
# CONFIGURE FUNCTION
#
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##

#========================================================================================================================#
#========================================================= ADMIN ========================================================#
#========================================================================================================================#

if [ "${GAIA_FOUND_DSI_HOST}" = true ]; then

	GAIA_HOST_ADMIN="DSI"

else

	GAIA_HOST_ADMIN="LABSIM"

fi

GAIA_ECOSYSTEM_DETAIL+="\n\t|\t* Administrator : $GAIA_HOST_ADMIN"

export GAIA_HOST_ADMIN

#========================================================================================================================#
#=========================================================== OS =========================================================#
#========================================================================================================================#

if [ -f /etc/os-release ]; then

	# freedesktop.org and systemd
	source "/etc/os-release"
	GAIA_HOST_OS="$NAME"
	GAIA_HOST_VER="$VERSION_ID"

elif type lsb_release >/dev/null 2>&1; then

	# linuxbase.org
	GAIA_HOST_OS="$(lsb_release -si)"
	GAIA_HOST_VER="$(lsb_release -sr)"

elif [ -f /etc/lsb-release ]; then

	# For some versions of Debian/Ubuntu without lsb_release command
	source "/etc/lsb-release"
	GAIA_HOST_OS="$DISTRIB_ID"
	GAIA_HOST_VER="$DISTRIB_RELEASE"

elif [ -f /etc/debian_version ]; then

	# Older Debian/Ubuntu/etc.
	GAIA_HOST_OS="Debian"
	GAIA_HOST_VER="$(cat /etc/debian_version)"

elif [ -f /etc/SuSe-release ]; then

	# Older SuSE/etc.    
	GAIA_HOST_OS="SuSe"
	GAIA_HOST_VER="$(cat /etc/SuSe-release)"

elif [ -f /etc/centos-release ]; then

	# Older CentOS, etc.
	GAIA_HOST_OS="CentOS"
	GAIA_HOST_VER="$(cat /etc/centos-release)"

elif [ -f /etc/redhat-release ]; then

	# Older Red Hat, etc.
	GAIA_HOST_OS="Red Hat"
	GAIA_HOST_VER="$(cat /etc/redhat-release)"

else

	# Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
	GAIA_HOST_OS="$(uname -s)"
	GAIA_HOST_VER="$(uname -r)"

fi

GAIA_ECOSYSTEM_DETAIL+="\n\t|\t* OS : $GAIA_HOST_OS"
GAIA_ECOSYSTEM_DETAIL+="\n\t|\t* Version : $GAIA_HOST_VER"

export GAIA_HOST_OS GAIA_HOST_VER

#========================================================================================================================#
#========================================================== ARCH ========================================================#
#========================================================================================================================#

case $(uname -m) in

	x86_64)
	    GAIA_HOST_ARCH="x64"	# or AMD64 or Intel64 or whatever
	    ;;

	i*86)
	    GAIA_HOST_ARCH="x86"	# or IA32 or Intel32 or whatever
	    ;;

	*)
	    GAIA_HOST_ARCH="unknown"    # default ARCH as-is
	    ;;

esac

GAIA_ECOSYSTEM_DETAIL+="\n\t|\t* Architecture : $GAIA_HOST_ARCH"

export GAIA_HOST_ARCH

#========================================================================================================================#
#======================================================= FEATURES =======================================================#
#========================================================================================================================#

# === third party feature

source "${GAIA_ROOT}/script/sh/feature/third_party-gnu.conf.sh"
source "${GAIA_ROOT}/script/sh/feature/third_party-common.conf.sh"
source "${GAIA_ROOT}/script/sh/feature/third_party-ig.conf.sh"
source "${GAIA_ROOT}/script/sh/feature/third_party-ip.conf.sh"
source "${GAIA_ROOT}/script/sh/feature/third_party-sf.conf.sh"
source "${GAIA_ROOT}/script/sh/feature/third_party-sb.conf.sh"
source "${GAIA_ROOT}/script/sh/feature/third_party-ui.conf.sh"
source "${GAIA_ROOT}/script/sh/feature/third_party-vr.conf.sh"

# === LABSIM software

source "${GAIA_ROOT}/script/sh/software/labsim-common.conf.sh"
source "${GAIA_ROOT}/script/sh/software/labsim-colosses.conf.sh"
source "${GAIA_ROOT}/script/sh/software/labsim-olympiens.conf.sh"
source "${GAIA_ROOT}/script/sh/software/labsim-titans.conf.sh"
source "${GAIA_ROOT}/script/sh/software/labsim-contract.conf.sh"

#========================================================================================================================#
#===================================================== END FEATURES =====================================================#
#========================================================================================================================#

# finalize dist detail
GAIA_ECOSYSTEM_DETAIL+="\n\t+\n"

# cleanup
source "${GAIA_ROOT}/script/sh/function/cleanup-env.conf.sh"
source "${GAIA_ROOT}/script/sh/function/cleanup-third_party.conf.sh"

# functions 

function __internal_labsim_gaia_ecosystem() {
	echo -e "\n## BEGIN LABSIM ROUTINES\n" \
	&& time perl -I "${GAIA_ROOT}/script/perl/module" "${GAIA_ROOT}/script/perl/gaia-ecosystem.pl" "$@"	\
	&& echo -e "\n## END LABSIM ROUTINES\n"
} # __internal_labsim_gaia_ecosystem()

function __internal_labsim_gaia_deploy() {
	echo -e "\n## BEGIN LABSIM ROUTINES\n" \
	&& time perl -I "${GAIA_ROOT}/script/perl/module" "${GAIA_ROOT}/script/perl/gaia-deploy.pl" "$@"	\
	&& echo -e "\n## END LABSIM ROUTINES\n"
} # __internal_labsim_gaia_deploy()

# aliases

alias gaia-ecosystem="__internal_labsim_gaia_ecosystem"
alias gaia-deploy="__internal_labsim_gaia_deploy"

##############################################################################
## Magic Section ! Fun, Functions and more ..				    ##
##############################################################################

#
# colored man :) --> #geek
# [ https://gist.github.com/cocoalabs/2fb7dc2199b0d4bf160364b8e557eb66 ]
#
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

# == EOF
