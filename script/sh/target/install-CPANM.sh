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

###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
#
# CONFIGURE FUNCTION
#
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##

function configure() {

	# print
	echo -ne "  + Configure... "

	# name
	GAIA_TARGET_PRETTY_NAME="cpanm"
	GAIA_TARGET_UC_NAME="$(echo "${GAIA_TARGET_PRETTY_NAME}" | tr '[:lower:]' '[:upper:]')"
	GAIA_TARGET_LC_NAME="$(echo "${GAIA_TARGET_PRETTY_NAME}" | tr '[:upper:]' '[:lower:]')"

	# directories
	GAIA_INITIAL_DIR="$PWD"
	GAIA_BUILD_DIR="/tmp/GAIA/$(whoami)/build/${GAIA_TARGET_LC_NAME}"
	GAIA_OFFLINE_DIR="/labsim/GAIA/${GAIA_HOST_OS}-${GAIA_HOST_VER}-${GAIA_HOST_ARCH}"
	
	# boolean
	GAIA_FOUND_AVAILABLE_NETWORK=false
	GAIA_FOUND_AVAILABLE_INTERNET_CONNECTIVITY=false

	# arguments 
	GAIA_TARGET_MAJOR="$1"
	GAIA_TARGET_MINOR="$2"
	GAIA_TARGET_PATCH="$3"
	GAIA_TARGET_VERSION="${GAIA_TARGET_MAJOR}.${GAIA_TARGET_MINOR}.${GAIA_TARGET_PATCH}"

	# build job parameter, save at least one core for OS & user :)
	GAIA_PARALLEL_BUILD_JOB_COUNT="$(nproc)"
	(( GAIA_PARALLEL_BUILD_JOB_COUNT = GAIA_PARALLEL_BUILD_JOB_COUNT > 1 ? --GAIA_PARALLEL_BUILD_JOB_COUNT : GAIA_PARALLEL_BUILD_JOB_COUNT ))

	# check at least one network card is available 
	for GAIA_NETWORK_ITERFACE_CARD in $(ls "/sys/class/net/" | grep -v lo);
	do
		
		if [[ "$(cat /sys/class/net/$GAIA_NETWORK_ITERFACE_CARD/carrier 2>/dev/null)" -eq 1 ]]; then
			GAIA_FOUND_AVAILABLE_NETWORK=true; 
		fi

	done

	# then check for internet connection
	if [ "${GAIA_FOUND_AVAILABLE_NETWORK}" = true ]; then

		case "$(curl -s --max-time 2 -I https://www.google.com | sed 's/^[^ ]*  *\([0-9]\).*/\1/; 1q')" in

			2|3) 
				GAIA_FOUND_AVAILABLE_INTERNET_CONNECTIVITY=true 
				echo -e "(connection HTTP => ONLINE MODE)... "
				;;

			5) 
				echo -e "(blocage du proxy ! verifier vos parametres d'environments aka. [http_proxy] && [https_proxy] => OFFLINE MODE)... "
				;;

			*)
				GAIA_FOUND_AVAILABLE_INTERNET_CONNECTIVITY=true 
				echo -e "(connection HTTP lente [ lag : >2s ] mais c'est OK, \"DSI\" => ONLINE MODE)... "
				;;

		esac

	else 

		echo -e "(pas de carte reseau connectee ! verifier vos parametres systemes et/ou contactez votre administrateur DSI => FAIL)... "
		exit 1

	fi
		
	# iff. interactive shell
	if hash gnome-terminal 2>/dev/null; then

		# import
		source "$GAIA_ROOT/script/sh/function/trap.conf.sh"
		source "$GAIA_ROOT/script/sh/function/pid.conf.sh"

	fi
	
	# env
	source "$GAIA_ROOT/script/sh/function/configure-third_party.conf.sh"

}

###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
#
# CLEANUP FUNCTION
#
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##

function cleanup() {

	# print
	echo -e "  + Cleanup... "

	# name
	unset GAIA_TARGET_PRETTY_NAME
	unset GAIA_TARGET_UC_NAME
	unset GAIA_TARGET_LC_NAME

	# directories
	unset GAIA_INITIAL_DIR
	unset GAIA_BUILD_DIR
	unset GAIA_OFFLINE_DIR

	# boolean
	unset GAIA_FOUND_AVAILABLE_NETWORK
	unset GAIA_FOUND_AVAILABLE_INTERNET_CONNECTIVITY

	# arguments 
	unset GAIA_TARGET_MAJOR
	unset GAIA_TARGET_MINOR
	unset GAIA_TARGET_PATCH
	unset GAIA_TARGET_VERSION

	# parameter
	unset GAIA_PARALLEL_BUILD_JOB_COUNT
	
	# env
	source "$GAIA_ROOT/script/sh/function/cleanup-third_party.conf.sh"

}

###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
#
# PRINT_HEADER FUNCTION
#
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##

function print_header() {

	echo
	echo "     ___  _______      ___       __       ___      ___   "
	echo "    /  / /  _____|    /   \     |  |     /   \     \  \  "
	echo "   /  / |  |  __     /  ^  \    |  |    /  ^  \     \  \ "
	echo "  <  <  |  | |_ |   /  /_\  \   |  |   /  /_\  \     >  >"
	echo "   \  \ |  |__| |  /  _____  \  |  |  /  _____  \   /  / "
	echo "    \__\ \______| /__/     \__\ |__| /__/     \__\ /__/  "
	echo "                            __                           "
	echo "                           |  |                          "
	echo "                           |  |                          "
	echo "                           |  |                          "
	echo "                           |  |                          "
	echo "                           |  |                          "
	echo "                           |__|                          "
	echo "                       ____    ____                      "
	echo "                       \   \  /   /                      "
	echo "                        \   \/   /                       "
	echo "                         \      /                        "
	echo "                          \    /                         "
	echo "                           \__/                          "
	echo "                                                         "
	echo

}

###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
#
# PRINT_FOOTER FUNCTION
#
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##

function print_footer() {
                                                      
	echo
	echo "   ___ ___________  __    __   _______     _______  __   __   _______  ___   "
	echo "  /  /|           ||  |  |  | |   ____|   |   ____||  \ |  | |       \ \  \  "
	echo " /  / '---|  |----'|  |__|  | |  |__      |  |__   |   \|  | |  .--.  | \  \ "
	echo "<  <      |  |     |   __   | |   __|     |   __|  |  . '  | |  |  |  |  >  >"
	echo " \  \     |  |     |  |  |  | |  |____    |  |____ |  |\   | |  '--'  | /  / "
	echo "  \__\    |__|     |__|  |__| |_______|   |_______||__| \__| |_______/ /__/  "                                                          
	echo

}

###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
#
# POP_CACHE FUNCTION
#
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##

function pop_cache() {

	chmod u+x exec.sh

	# check  
	if hash gnome-terminal 2>/dev/null; then

		# add interactive prompt
		echo "read -p \"Appuyez sur [Entree] pour continuer...\"" >> exec.sh

		# display a nice & interactive procedure
		echo -ne "\t==(interactive mode)"
        gnome-terminal --working-directory "$PWD" --title "LABSIM - ${GAIA_TARGET_UC_NAME} ${GAIA_TARGET_VERSION}" --hide-menubar --command "./exec.sh" --window
		sleep 0.2
		PID="$(pgrep exec.sh)"
		wait_for_PID "$PID"
		echo -e "==> OK"

    else

		# non-interactive so we need to source GAIA env into current terminal
		echo -e "\t==(non-interactive mode)=X"
		/bin/bash -c "source ${GAIA_ROOT}/script/sh/GAIA.bashrc && ./exec.sh"
    
	fi

}

###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
#
# PUSH_CPANM_OP_TO_CACHE FUNCTION
#
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##

function push_cpanm_op_to_cache() {

	# print
	echo -ne "  + Installation des modules ${GAIA_TARGET_PRETTY_NAME} necessaires... "

	# finally, the op
	echo "#!/bin/bash" > exec.sh
	echo "if ! cpanm < /dev/null > /dev/null 2>&1 ; then cpan App::cpanminus; fi" >> exec.sh
	echo "${GAIA_TARGET_PRETTY_NAME} --verbose List::Util" >> exec.sh
	echo "${GAIA_TARGET_PRETTY_NAME} --verbose local::lib" >> exec.sh
	echo "${GAIA_TARGET_PRETTY_NAME} --verbose FindBin" >> exec.sh
	echo "${GAIA_TARGET_PRETTY_NAME} --verbose Switch" >> exec.sh
	echo "${GAIA_TARGET_PRETTY_NAME} --verbose Env" >> exec.sh
	echo "${GAIA_TARGET_PRETTY_NAME} --verbose Config" >> exec.sh
	echo "${GAIA_TARGET_PRETTY_NAME} --verbose Getopt::Long" >> exec.sh
	echo "${GAIA_TARGET_PRETTY_NAME} --verbose Pod::Usage" >> exec.sh
	echo "${GAIA_TARGET_PRETTY_NAME} --verbose Term::ANSIColor" >> exec.sh
	echo "${GAIA_TARGET_PRETTY_NAME} --verbose Time::HiRes" >> exec.sh
	echo "${GAIA_TARGET_PRETTY_NAME} --verbose Data::Dumper" >> exec.sh
	echo "${GAIA_TARGET_PRETTY_NAME} --verbose File::Copy::Recursive" >> exec.sh
	echo "${GAIA_TARGET_PRETTY_NAME} --verbose File::Remove" >> exec.sh
	echo "${GAIA_TARGET_PRETTY_NAME} --verbose File::Spec" >> exec.sh
	echo "${GAIA_TARGET_PRETTY_NAME} --verbose File::HomeDir" >> exec.sh
	echo "${GAIA_TARGET_PRETTY_NAME} --verbose YAML::XS" >> exec.sh
	echo "${GAIA_TARGET_PRETTY_NAME} --verbose Net::Address::IP::Local" >> exec.sh
	echo "${GAIA_TARGET_PRETTY_NAME} --verbose IPC::System::Simple" >> exec.sh
	echo "${GAIA_TARGET_PRETTY_NAME} --verbose IPC::Cmd" >> exec.sh
	echo "${GAIA_TARGET_PRETTY_NAME} --verbose XML::SimpleObject::LibXML" >> exec.sh
	echo "${GAIA_TARGET_PRETTY_NAME} --verbose Graph" >> exec.sh
	
}

###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
#
# MAIN SCRIPT
#
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##

# == start ==
print_header

	# == init ==
	configure "$@"

	# == cpan ==
	push_cpanm_op_to_cache
	pop_cache

	# == close ==
	cleanup

print_footer
# == end ==

# final - success
exit

### EOF