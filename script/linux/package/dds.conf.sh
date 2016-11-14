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
# DDS environment config
#
# Ce fichier defini les variables necessaires aux projet RHEA & KRONOS 
# ainsi que celles necessaires au Progiciel OpenSpliceDDS
#
# 07/02/12 - Kinani Nawfel
#######################

###################################################################
# OpenSpliceDDS
###
# OSPL ROOT - The home of the Open SPLice global project
# OSPL HDE ROOT - The home of the OSPL project Host Development Environment (Configured)
# OSPL RTS ROOT - The home of the OSPL project RunTime Sofware (Configured)
# We source the release.com file generated which contain all the variable definition
###

OSPL_ROOT=$PRO_HOME/opensplicedds-$OSPL_VERSION
OSPL_TARGET=x86_64.linux
OSPL_RTS_ROOT=$OSPL_ROOT/RTS/$OSPL_TARGET
OSPL_HDE_ROOT=$OSPL_ROOT/HDE/$OSPL_TARGET
OSPL_LOGPATH=$OSPL_ROOT/log
OSPL_STOREPATH=$OSPL_ROOT/store
OSPL_CONFPATH=$OSPL_ROOT/config

export OSPL_TARGET OSPL_ROOT OSPL_RTS_ROOT OSPL_HDE_ROOT OSPL_LOGPATH OSPL_STOREPATH OSPL_CONFPATH

###################################################################
# OpenSpliceDDS Daemon configuration
###
# OSPL_URI - The URI to the global ospl daemon configuration xml file
###

OSPL_URI=file://$OSPL_CONFPATH/ospl_simulation_conf.xml

export OSPL_URI

###################################################################
# Sourcing - except during install
###
if [ -z ${GAIA_REQUIRE_CLEAN_DDS_INSTALL_ENVIRONMENT+x} ]; then
	source "$OSPL_HDE_ROOT/release.com"
fi

###################################################################
# ++ depreciated ++ Auxilliary stuff - RHEL5 Compatibility header under CentOS
###

#if [ -d /usr/lib/x86_64-redhat-linux5E/include/ ]; then
#	RHEL5_COMPAT_HEADER_INCLUDEDIR=/usr/lib/x86_64-redhat-linux5E/include/
#	C_INCLUDE_PATH=$RHEL5_COMPAT_HEADER_INCLUDEDIR:$C_INCLUDE_PATH
#	CPLUS_INCLUDE_PATH=$RHEL5_COMPAT_HEADER_INCLUDEDIR:$CPLUS_INCLUDE_PATH
#	export C_INCLUDE_PATH CPLUS_INCLUDE_PATH RHEL5_COMPAT_HEADER_INCLUDEDIR
#else
#	echo "!! installation du package compat-glibc-headers-2.5-46.2.x86_64 nécéssaire afin d'assurer la compatibilité RHEL !!"
#fi

