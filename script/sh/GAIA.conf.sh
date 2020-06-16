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
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )/../.." >/dev/null 2>&1 && pwd )"

# GAIA root dir
export GAIA_ROOT="${DIR}"

# Distribution detail
export GAIA_ECOSYSTEM_DETAIL=""

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

if type lsb_release >/dev/null 2>&1; then

	# linuxbase.org
	GAIA_HOST_OS="$(lsb_release -si)"
	GAIA_HOST_VER="$(lsb_release -sr)"
	
elif [ -f /etc/os-release ]; then

	# freedesktop.org and systemd
	source "/etc/os-release"
	GAIA_HOST_OS="$NAME"
	GAIA_HOST_VER="$VERSION_ID"

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

for GAIA_FEATURE_CONF_FILE in $(find "${GAIA_ROOT}/script/sh/feature/" -type f -iname "*.conf.sh"); do

	source "${GAIA_FEATURE_CONF_FILE}"

done

unset GAIA_FEATURE_CONF_FILE

#========================================================================================================================#
#======================================================= SOFTWARE =======================================================#
#========================================================================================================================#

# === LABSIM software

for GAIA_SOFTWARE_CONF_FILE in $(find "${GAIA_ROOT}/script/sh/software/" -type f -iname "*.conf.sh"); do

	source "${GAIA_SOFTWARE_CONF_FILE}"

done

unset GAIA_SOFTWARE_CONF_FILE

export LABSIM_VERBOSITY_LEVEL="INFO"

#========================================================================================================================#
#===================================================== END FEATURES =====================================================#
#========================================================================================================================#

# finalize dist detail
GAIA_ECOSYSTEM_DETAIL+="\n\t+\n"

# cleanup
source "${GAIA_ROOT}/script/sh/function/cleanup-env.conf.sh"
source "${GAIA_ROOT}/script/sh/function/cleanup-third_party.conf.sh"

# function

function gaia() {
	echo -e "\n## BEGIN LABSIM ROUTINES\n" \
	&& time perl "${GAIA_ROOT}/GAIA.pl" "$@"	\
	&& echo -e "\n## END LABSIM ROUTINES\n"
} # gaia()

# default language -> easier
#export LANG=en_US.UTF-8

##############################################################################
## Magic Section ! Fun, Functions and more ..				    ##
##############################################################################

#
# colored man :) --> #geek
# [ https://gist.github.com/cocoalabs/2fb7dc2199b0d4bf160364b8e557eb66 ]
#
function man() {
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

# show weather CSP :)
alias weather='curl wttr.in/Manchester'

# pretty 'ls' & 'grep
alias ls='ls --color=auto --human-readable --group-directories-first --classify'
alias grep='grep --color=auto'

# == EOF
