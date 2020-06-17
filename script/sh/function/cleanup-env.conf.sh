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

# http://unix.stackexchange.com/questions/40749/remove-duplicate-path-entries-with-awk-command ... What else ?...

if [ -n "$PATH" ]; then
	old_PATH=$PATH:; PATH=
	while [ -n "$old_PATH" ]; do
		x=${old_PATH%%:*}        	# the first remaining entry
		case $PATH: in
			*:"$x":*) ;;         	# already there
			*) PATH=$PATH:$x;;   	# not there yet
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
			*:"$x":*) ;;         				# already there
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

# Cotire/CMake need CPLUS_INCLUDE_PATH but gcc need CPATH sooo :) ...
export CPLUS_INCLUDE_PATH=$CPATH

if [ -n "$PKG_CONFIG_PATH" ]; then
	old_PKG_CONFIG_PATH=$PKG_CONFIG_PATH:; PKG_CONFIG_PATH=
	while [ -n "$old_PKG_CONFIG_PATH" ]; do
		x=${old_PKG_CONFIG_PATH%%:*}        			# the first remaining entry
		case $PKG_CONFIG_PATH: in
			*:"$x":*) ;;         				# already there
			*) PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$x;;   	# not there yet
		esac
		old_PKG_CONFIG_PATH=${old_PKG_CONFIG_PATH#*:}
	done
	PKG_CONFIG_PATH=${PKG_CONFIG_PATH#:}
	unset old_PKG_CONFIG_PATH x
fi

export PATH LD_LIBRARY_PATH CPATH PKG_CONFIG_PATH

return 0
# == EOF
