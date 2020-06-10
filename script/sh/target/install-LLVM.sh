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
	GAIA_TARGET_PRETTY_NAME="LLVM"
	GAIA_TARGET_UC_NAME="$(echo ${GAIA_TARGET_PRETTY_NAME} | tr '[:lower:]' '[:upper:]')"
	GAIA_TARGET_LC_NAME="$(echo ${GAIA_TARGET_PRETTY_NAME} | tr '[:upper:]' '[:lower:]')"

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
# MAKE_TEMPORARY_DIRECTORIES FUNCTION
#
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##

function make_temporary_directories() {

	# build local dir & remove previous
	if [ -d "$GAIA_BUILD_DIR" ]; then 
		rm -rf $GAIA_BUILD_DIR
	fi
	mkdir --parents $GAIA_BUILD_DIR

}

###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
#
# REMOVE_TEMPORARY_DIRECTORIES FUNCTION
#
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##

function remove_temporary_directories() {
                                          
	rm -rf $GAIA_BUILD_DIR

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
# PUSH_DOWNLOAD_OP_TO_CACHE FUNCTION
#
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##

function push_download_op_to_cache() {

	# print
	echo -ne "  + Telechargement de ${GAIA_TARGET_PRETTY_NAME} ${GAIA_TARGET_VERSION}... "

	# the op
	echo "#!/bin/bash" > exec.sh
	
	if [ "${GAIA_FOUND_AVAILABLE_INTERNET_CONNECTIVITY}" = true ]; then
		
		echo "echo \"================== llvm ==================\"" >> exec.sh
		echo "wget http://releases.${GAIA_TARGET_LC_NAME}.org/${GAIA_TARGET_VERSION}/${GAIA_TARGET_LC_NAME}-${GAIA_TARGET_VERSION}.src.tar.xz" >> exec.sh
		echo "mv ${GAIA_TARGET_LC_NAME}-${GAIA_TARGET_VERSION}.src.tar.xz ${GAIA_TARGET_LC_NAME}-${GAIA_TARGET_VERSION}.tar.xz" >> exec.sh
		
		echo "echo \"================== llvm/tools/clang ==================\"" >> exec.sh
		echo "wget http://releases.${GAIA_TARGET_LC_NAME}.org/${GAIA_TARGET_VERSION}/cfe-${GAIA_TARGET_VERSION}.src.tar.xz" >> exec.sh
		echo "mv cfe-${GAIA_TARGET_VERSION}.src.tar.xz cfe-${GAIA_TARGET_VERSION}.tar.xz" >> exec.sh
		
		echo "echo \"================== llvm/tools/clang/tools/extra ==================\"" >> exec.sh
		echo "wget http://releases.${GAIA_TARGET_LC_NAME}.org/${GAIA_TARGET_VERSION}/clang-tools-extra-${GAIA_TARGET_VERSION}.src.tar.xz" >> exec.sh
		echo "mv clang-tools-extra-${GAIA_TARGET_VERSION}.src.tar.xz clang-tools-extra-${GAIA_TARGET_VERSION}.tar.xz" >> exec.sh
		
		echo "echo \"================== llvm/tools/lld ==================\"" >> exec.sh
		echo "wget http://releases.${GAIA_TARGET_LC_NAME}.org/${GAIA_TARGET_VERSION}/lld-${GAIA_TARGET_VERSION}.src.tar.xz" >> exec.sh
		echo "mv lld-${GAIA_TARGET_VERSION}.src.tar.xz lld-${GAIA_TARGET_VERSION}.tar.xz" >> exec.sh
		
		echo "echo \"================== llvm/tools/lldb ==================\"" >> exec.sh
		echo "wget http://releases.${GAIA_TARGET_LC_NAME}.org/${GAIA_TARGET_VERSION}/lldb-${GAIA_TARGET_VERSION}.src.tar.xz" >> exec.sh
		echo "mv lldb-${GAIA_TARGET_VERSION}.src.tar.xz	lldb-${GAIA_TARGET_VERSION}.tar.xz" >> exec.sh
		
		echo "echo \"================== llvm/tools/polly ==================\"" >> exec.sh
		echo "wget http://releases.${GAIA_TARGET_LC_NAME}.org/${GAIA_TARGET_VERSION}/polly-${GAIA_TARGET_VERSION}.src.tar.xz" >> exec.sh
		echo "mv polly-${GAIA_TARGET_VERSION}.src.tar.xz polly-${GAIA_TARGET_VERSION}.tar.xz" >> exec.sh
		
		echo "echo \"================== llvm/projects/compiler-rt ==================\"" >> exec.sh
		echo "wget http://releases.${GAIA_TARGET_LC_NAME}.org/${GAIA_TARGET_VERSION}/compiler-rt-${GAIA_TARGET_VERSION}.src.tar.xz" >> exec.sh
		echo "mv compiler-rt-${GAIA_TARGET_VERSION}.src.tar.xz compiler-rt-${GAIA_TARGET_VERSION}.tar.xz" >> exec.sh
		
		echo "echo \"================== llvm/projects/openmp ==================\"" >> exec.sh
		echo "wget http://releases.${GAIA_TARGET_LC_NAME}.org/${GAIA_TARGET_VERSION}/openmp-${GAIA_TARGET_VERSION}.src.tar.xz" >> exec.sh
		echo "mv openmp-${GAIA_TARGET_VERSION}.src.tar.xz openmp-${GAIA_TARGET_VERSION}.tar.xz" >> exec.sh
		
		echo "echo \"================== llvm/projects/libcxx ==================\"" >> exec.sh
		echo "wget http://releases.${GAIA_TARGET_LC_NAME}.org/${GAIA_TARGET_VERSION}/libcxx-${GAIA_TARGET_VERSION}.src.tar.xz" >> exec.sh
		echo "mv libcxx-${GAIA_TARGET_VERSION}.src.tar.xz libcxx-${GAIA_TARGET_VERSION}.tar.xz" >> exec.sh
		
		echo "echo \"================== llvm/projects/libcxxabi ==================\"" >> exec.sh
		echo "wget http://releases.${GAIA_TARGET_LC_NAME}.org/${GAIA_TARGET_VERSION}/libcxxabi-${GAIA_TARGET_VERSION}.src.tar.xz" >> exec.sh
		echo "mv libcxxabi-${GAIA_TARGET_VERSION}.src.tar.xz libcxxabi-${GAIA_TARGET_VERSION}.tar.xz" >> exec.sh
		
		echo "echo \"================== llvm/projects/libunwind ==================\"" >> exec.sh
		echo "wget http://releases.${GAIA_TARGET_LC_NAME}.org/${GAIA_TARGET_VERSION}/libunwind-${GAIA_TARGET_VERSION}.src.tar.xz" >> exec.sh
		echo "mv libunwind-${GAIA_TARGET_VERSION}.src.tar.xz libunwind-${GAIA_TARGET_VERSION}.tar.xz" >> exec.sh
		
	else 
		
		echo "echo \"================== llvm ==================\"" >> exec.sh
		echo "cp --verbose ${GAIA_OFFLINE_DIR}/${GAIA_TARGET_LC_NAME}-${GAIA_TARGET_VERSION}.tar.xz ." >> exec.sh
		
		echo "echo \"================== llvm/tools/clang ==================\"" >> exec.sh
		echo "cp --verbose ${GAIA_OFFLINE_DIR}/cfe-${GAIA_TARGET_VERSION}.tar.xz ." >> exec.sh
		
		echo "echo \"================== llvm/tools/clang/tools/extra ==================\"" >> exec.sh
		echo "cp --verbose ${GAIA_OFFLINE_DIR}/clang-tools-extra-${GAIA_TARGET_VERSION}.tar.xz ." >> exec.sh
		
		echo "echo \"================== llvm/tools/lld ==================\"" >> exec.sh
		echo "cp --verbose ${GAIA_OFFLINE_DIR}/lld-${GAIA_TARGET_VERSION}.tar.xz ." >> exec.sh
		
		echo "echo \"================== llvm/tools/lldb ==================\"" >> exec.sh
		echo "cp --verbose ${GAIA_OFFLINE_DIR}/lldb-${GAIA_TARGET_VERSION}.tar.xz ." >> exec.sh
		
		echo "echo \"================== llvm/tools/polly ==================\"" >> exec.sh
		echo "cp --verbose ${GAIA_OFFLINE_DIR}/polly-${GAIA_TARGET_VERSION}.tar.xz ." >> exec.sh
		
		echo "echo \"================== llvm/projects/compiler-rt ==================\"" >> exec.sh
		echo "cp --verbose ${GAIA_OFFLINE_DIR}/compiler-rt-${GAIA_TARGET_VERSION}.tar.xz ." >> exec.sh
		
		echo "echo \"================== llvm/projects/openmp ==================\"" >> exec.sh
		echo "cp --verbose ${GAIA_OFFLINE_DIR}/openmp-${GAIA_TARGET_VERSION}.tar.xz ." >> exec.sh
		
		echo "echo \"================== llvm/projects/libcxx ==================\"" >> exec.sh
		echo "cp --verbose ${GAIA_OFFLINE_DIR}/libcxx-${GAIA_TARGET_VERSION}.tar.xz ." >> exec.sh
		
		echo "echo \"================== llvm/projects/libcxxabi ==================\"" >> exec.sh
		echo "cp --verbose ${GAIA_OFFLINE_DIR}/libcxxabi-${GAIA_TARGET_VERSION}.tar.xz ." >> exec.sh
		
		echo "echo \"================== llvm/projects/libunwind ==================\"" >> exec.sh
		echo "cp --verbose ${GAIA_OFFLINE_DIR}/libunwind-${GAIA_TARGET_VERSION}.tar.xz ." >> exec.sh
		
	fi

}

###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
#
# PUSH_EXTRACT_OP_TO_CACHE FUNCTION
#
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##

function push_extract_op_to_cache() {

	# print
	echo -ne "  + Decompression de ${GAIA_TARGET_PRETTY_NAME} ${GAIA_TARGET_VERSION}..."

	# the op
	echo "#!/bin/bash" > exec.sh
	echo "echo \"================== llvm ==================\"" >> exec.sh
	echo "mkdir llvm && tar -xvf ${GAIA_TARGET_LC_NAME}-${GAIA_TARGET_VERSION}.tar.xz --directory=llvm --strip-components=1" >> exec.sh
	echo "rm ${GAIA_TARGET_LC_NAME}-${GAIA_TARGET_VERSION}.tar.xz" >> exec.sh
	
	echo "echo \"================== llvm/tools/clang ==================\"" >> exec.sh
	echo "mkdir llvm/tools/clang && tar -xvf cfe-${GAIA_TARGET_VERSION}.tar.xz --directory=llvm/tools/clang --strip-components=1" >> exec.sh
	echo "rm cfe-${GAIA_TARGET_VERSION}.tar.xz" >> exec.sh
	
	echo "echo \"================== llvm/tools/clang/tools/extra ==================\"" >> exec.sh
	echo "mkdir llvm/tools/clang/tools && tar -xvf clang-tools-extra-${GAIA_TARGET_VERSION}.tar.xz --directory=llvm/tools/clang/tools --strip-components=1" >> exec.sh
	echo "rm clang-tools-extra-${GAIA_TARGET_VERSION}.tar.xz" >> exec.sh
	
	echo "echo \"================== llvm/tools/lld ==================\"" >> exec.sh
	echo "mkdir llvm/tools/lld && tar -xvf lld-${GAIA_TARGET_VERSION}.tar.xz --directory=llvm/tools/lld --strip-components=1" >> exec.sh
	echo "rm lld-${GAIA_TARGET_VERSION}.tar.xz" >> exec.sh
	
	echo "echo \"================== llvm/tools/lldb ==================\"" >> exec.sh
	echo "mkdir llvm/tools/lldb && tar -xvf lldb-${GAIA_TARGET_VERSION}.tar.xz --directory=llvm/tools/lldb --strip-components=1" >> exec.sh
	echo "rm lldb-${GAIA_TARGET_VERSION}.tar.xz" >> exec.sh
	
	echo "echo \"================== llvm/tools/polly ==================\"" >> exec.sh
	echo "mkdir llvm/tools/polly && tar -xvf polly-${GAIA_TARGET_VERSION}.tar.xz --directory=llvm/tools/polly --strip-components=1" >> exec.sh
	echo "rm polly-${GAIA_TARGET_VERSION}.tar.xz" >> exec.sh
	
	echo "echo \"================== llvm/projects/compiler-rt ==================\"" >> exec.sh
	echo "mkdir llvm/projects/compiler-rt && tar -xvf compiler-rt-${GAIA_TARGET_VERSION}.tar.xz --directory=llvm/projects/compiler-rt --strip-components=1" >> exec.sh
	echo "rm compiler-rt-${GAIA_TARGET_VERSION}.tar.xz" >> exec.sh
	
	echo "echo \"================== llvm/projects/openmp ==================\"" >> exec.sh
	echo "mkdir llvm/projects/openmp && tar -xvf openmp-${GAIA_TARGET_VERSION}.tar.xz --directory=llvm/projects/openmp --strip-components=1" >> exec.sh
	echo "rm openmp-${GAIA_TARGET_VERSION}.tar.xz" >> exec.sh
	
	echo "echo \"================== llvm/projects/libcxx ==================\"" >> exec.sh
	echo "mkdir llvm/projects/libcxx && tar -xvf libcxx-${GAIA_TARGET_VERSION}.tar.xz --directory=llvm/projects/libcxx --strip-components=1" >> exec.sh
	echo "rm libcxx-${GAIA_TARGET_VERSION}.tar.xz" >> exec.sh
	
	echo "echo \"================== llvm/projects/libcxxabi ==================\"" >> exec.sh
	echo "mkdir llvm/projects/libcxxabi && tar -xvf libcxxabi-${GAIA_TARGET_VERSION}.tar.xz --directory=llvm/projects/libcxxabi --strip-components=1" >> exec.sh
	echo "rm libcxxabi-${GAIA_TARGET_VERSION}.tar.xz" >> exec.sh
	
	echo "echo \"================== llvm/projects/libunwind ==================\"" >> exec.sh
	echo "mkdir llvm/projects/libunwind && tar -xvf libunwind-${GAIA_TARGET_VERSION}.tar.xz --directory=llvm/projects/libunwind --strip-components=1" >> exec.sh
	echo "rm libunwind-${GAIA_TARGET_VERSION}.tar.xz" >> exec.sh

}

###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
#
# PUSH_CONFIGURE_OP_TO_CACHE FUNCTION
#
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##

function push_configure_op_to_cache() {

	# print
	echo -ne "  + CMake de ${GAIA_TARGET_PRETTY_NAME} ${GAIA_TARGET_VERSION}..."

	# navigate
	mkdir build
	cd build

	# cmake exist
	echo "#!/bin/bash" > exec.sh
	echo "cmake -DCMAKE_INSTALL_PREFIX=${GAIA_THIRD_PARTY_HOME}/${GAIA_TARGET_LC_NAME}-${GAIA_TARGET_VERSION} -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_RTTI=ON  -DLLVM_INSTALL_UTILS=ON -DLLVM_BINUTILS_INCDIR=${GAIA_THIRD_PARTY_HOME}/binutils-${GAIA_THIRD_PARTY_BINUTILS_VERSION} .." >> exec.sh

}

###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
#
# PUSH_BUILD_OP_TO_CACHE FUNCTION
#
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##

function push_build_op_to_cache() {

	# print
	echo -ne "  + Build de ${GAIA_TARGET_PRETTY_NAME} ${GAIA_TARGET_VERSION}..."

	# the op
	echo "#!/bin/bash" > exec.sh
	echo "cmake --build . -- -j${GAIA_PARALLEL_BUILD_JOB_COUNT}" >> exec.sh

}

###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
#
# PUSH_INSTALL_OP_TO_CACHE FUNCTION
#
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##

function push_install_op_to_cache() {

	# print
	echo -ne "  + Install de ${GAIA_TARGET_PRETTY_NAME} ${GAIA_TARGET_VERSION}..."

	# the op
	echo "#!/bin/bash" > exec.sh
	echo "cmake --build . --target install" >> exec.sh

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
	make_temporary_directories

	# --> navigate
	cd "$GAIA_BUILD_DIR"

	# == download ==
	push_download_op_to_cache
	pop_cache

	# == extract ==
	push_extract_op_to_cache
	pop_cache

	# --> navigate
	cd ${GAIA_TARGET_LC_NAME}*

	# == configure ==
	push_configure_op_to_cache
	pop_cache

	# == build ==
	push_build_op_to_cache
	pop_cache

	# == install ==
	push_install_op_to_cache
	pop_cache

	# --> navigate
	cd "$GAIA_INITIAL_DIR"

	# == close ==
	remove_temporary_directories
	cleanup

print_footer
# == end ==

# final - success
exit

### EOF
