#!/bin/bash

#######################
# global environment config
#
# Ce fichier est inclu depuis /etc/profile au demarrage de la machine
# ou alors par le fichier .bashrc lors de l'ouverture d'un terminal
#
# 07/02/12 - Kinani Nawfel
#######################

###################################################################
# TAO - OpenFusionTAO
###
# ACE ROOT - The home of the ADAPTIVE Communication Environment
# TAO ROOT - The home of The Ace Orb
# TAO IDL - The Interface Definition Language compiler 
###

ACE_ROOT=$PRO_HOME/OpenFusionTAO
TAO_ROOT=$PRO_HOME/OpenFusionTAO
TAO_IDL=$PRO_HOME/OpenFusionTAO/bin/tao_idl

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
OSPL_RTS_ROOT=$OSPL_ROOT/RTS/x86_64.linux2.6-dev
OSPL_HDE_ROOT=$OSPL_ROOT/HDE/x86_64.linux2.6-dev
OSPL_LOGPATH=$OSPL_ROOT/log
OSPL_STOREPATH=$OSPL_ROOT/store
OSPL_CONFPATH=$OSPL_ROOT/config

export OSPL_ROOT OSPL_RTS_ROOT OSPL_HDE_ROOT OSPL_LOGPATH OSPL_STOREPATH OSPL_CONFPATH

###################################################################
# OpenSpliceDDS Daemon configuration
###
# OSPL_LIPS_CONF_URI - The URI to the global ospl daemon configuration xml file
###

OSPL_URI=file://$OSPL_CONFPATH/ospl_simulation_conf.xml

export OSPL_URI

###################################################################
# SimD - Simple DDS API
###

SIMD_INSTALL_DIR=$PRO_HOME/SimD

export SIMD_INSTALL_DIR

###################################################################
# CERTI & GENESIS
###
CERTI_HOME=$CODES_HOME/certi-3.4.2-dev1-x86_64-linux2.6-centos
GENESIS_HOME=$CODES_HOME/genesis-x86_64-linux2.6-centos
CERTI_HTTP_PROXY=
CERTI_UDP_PORT=55555
CERTI_TCP_PORT=55555

export CERTI_HOME GENESIS_HOME CERTI_HTTP_PROXY CERTI_UDP_PORT CERTI_TCP_PORT

###################################################################
# Sourcing
###

source "$OSPL_HDE_ROOT/release.com"

###################################################################
# Global Variable
###

PATH=:$PATH\
:$TAO_ROOT/bin\
:$CERTI_HOME/bin

LD_LIBRARY_PATH=$LD_LIBRARY_PATH\
:$TAO_ROOT/lib\
:$CERTI_HOME/lib\
:$GENESIS_HOME/CERTI32/lib

INSLIB=$TAO_ROOT/lib:$INSLIB

export PATH LD_LIBRARY_PATH INSLIB
