#!/bin/bash

#######################
# DDS environment config
#
# Ce fichier defini les variables necessaires aux projet RHEA & KRONOS 
# ainsi que celles necessaires aux Progiciels OpenSpliceDDS, 
# OpenFusionTAO & SimD
#
# 07/02/12 - Kinani Nawfel
#######################

###################################################################
# RHEA 
###

RHEA_ROOT=$DEV_HOME/Titans/RHEA/$DEV_SUBDIR

export RHEA_ROOT

alias rhea="$RHEA_ROOT/script/RHEA.sh"

###################################################################
# KRONOS-DDS 
###

KRONOSDDS_ROOT=$DEV_HOME/Titans/KRONOS-DDS/$DEV_SUBDIR
KRONOSDDS_INCLUDEDIR=$KRONOSDDS_ROOT/include
KRONOSDDS_LIBRARYDIR=$KRONOSDDS_ROOT/lib
KRONOSDDS_BINARYDIR=$KRONOSDDS_ROOT/bin

export KRONOSDDS_ROOT KRONOSDDS_INCLUDEDIR KRONOSDDS_LIBRARYDIR KRONOSDDS_BINARYDIR

###################################################################
# KRONOS-IDL
###

KRONOSIDL_ROOT=$KRONOSDDS_ROOT/idl
KRONOSIDL_INCLUDEDIR="$KRONOSIDL_ROOT/include $KRONOSIDL_ROOT/traits"
KRONOSIDL_LIBRARYDIR=$KRONOSDDS_LIBRARYDIR
KRONOSIDL_BINARYDIR=$KRONOSDDS_BINARYDIR

export KRONOSIDL_ROOT KRONOSIDL_INCLUDEDIR KRONOSIDL_LIBRARYDIR KRONOSIDL_BINARYDIR

###################################################################
# TAO - OpenFusionTAO
###
# ACE ROOT - The home of the ADAPTIVE Communication Environment
# TAO ROOT - The home of The Ace Orb
# TAO IDL - The Interface Definition Language compiler 
###

ACE_ROOT=$PRO_HOME/OpenFusionTAO
TAO_ROOT=$PRO_HOME/OpenFusionTAO
TAO_IDL=$TAO_ROOT/bin/tao_idl

export ACE_ROOT TAO_ROOT TAO_IDL

###################################################################
# OpenSpliceDDS
###
# OSPL ROOT - The home of the Open SPLice global project
# OSPL HDE ROOT - The home of the OSPL project Host Development Environment (Configured)
# OSPL RTS ROOT - The home of the OSPL project RunTime Sofware (Configured)
# We source the release.com file generated which contain all the variable definition
###

OSPL_ROOT=$PRO_HOME/OpenSpliceDDS
OSPL_TARGET=x86_64.linux2.6
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
# SimD - Simple DDS API
###

SIMD_INSTALL_DIR=$PRO_HOME/SimD

export SIMD_INSTALL_DIR

###################################################################
# Sourcing
###

source "$OSPL_HDE_ROOT/release.com"

###################################################################
# Auxilliary stuff - RHEL5 Compatibility header under CentOS
###

if [ -d /usr/lib/x86_64-redhat-linux5E/include/ ]; then
	RHEL5_COMPAT_HEADER_INCLUDEDIR=/usr/lib/x86_64-redhat-linux5E/include/
	C_INCLUDE_PATH=$RHEL5_COMPAT_HEADER_INCLUDEDIR:$C_INCLUDE_PATH
	CPLUS_INCLUDE_PATH=$RHEL5_COMPAT_HEADER_INCLUDEDIR:$CPLUS_INCLUDE_PATH
	export C_INCLUDE_PATH CPLUS_INCLUDE_PATH RHEL5_COMPAT_HEADER_INCLUDEDIR
else
	echo "!! installation du package compat-glibc-headers-2.5-46.2.x86_64 nécéssaire afin d'assurer la compatibilité RHEL !!"
fi


###################################################################
# Global Variable
###

PATH=$PATH\
:$KRONOSDDS/bin\
:$TAO_ROOT/bin

LD_LIBRARY_PATH=$LD_LIBRARY_PATH\
:$KRONOSDDS_LIBRARYDIR\
:$TAO_ROOT/lib

INSLIB=$INSLIB\
:$TAO_ROOT/lib

###################################################################
# Exporting
###

export PATH LD_LIBRARY_PATH INSLIB
