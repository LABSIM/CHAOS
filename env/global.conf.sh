#!/bin/bash

#######################
# global environment config
#
# Ce fichier est inclu depuis /etc/profile au demarrage de la machine
# ou alors par le fichier .bashrc lors de l'ouverture d'un terminal
#
# 07/02/12 - Kinani Nawfel
#######################

###
# Informations
###
function infoenv()
{
	echo "=========================================================================="
 	echo " Environment de dev courant : ${ELIPS_CURRENT_DIST}"
	echo "=========================================================================="
}

###
# Switch
###
function switchenv()
{
	if [ -f /home/elips/dev_conf/scripts/switchenv.sh ]; then 
		$(cd "/home/elips/dev_conf/scripts/" && sh "switchenv.sh")
	fi
}


###################################################################
# Home path
###
 
PRO_HOME=/home/elips/Progiciels
CODES_HOME=/home/elips/CODES
BDD_HOME=/data/bdd

export PRO_HOME CODES_HOME BDD_HOME

###################################################################
# ELIPS 
###

ELIPS_HOME=~/dev/ELIPS/$ELIPS_SUBDIR
ELIPSHOME=$ELIPS_HOME
LC_NUMERIC=en_US

export ELIPSHOME ELIPS_HOME LC_NUMERIC

alias menage="$ELIPS_HOME/etc/menage.sh"
alias cleanipc="$ELIPS_HOME/etc/cleanipc.sh"
alias ELIPSutil="konqueror $ELIPS_HOME/doc/html/PDF/ELIPS-RT2005_utilisateur.pdf"
alias VENUShelp="konqueror $ELIPS_HOME/doc/html/PDF/VENUS-RT2005.pdf"
alias ELIPShelp="konqueror $ELIPS_HOME/doc/html/index.html"

###################################################################
# VISUEL PA 
###

IMAGE_PA_PATH=$BDD_HOME/IMAGE_PA

export IMAGE_PA_PATH

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
# OpenSceneGraph
###

OSG_VERSION=
OSG_ROOT=$PRO_HOME/OSG$OSG_VERSION/
OSGDIR=$OSG_ROOT

OSG_TEXTURE=$BDD_HOME/VEHICULES/Txt\
:$BDD_HOME/BLAGNAC_IVE/texture/rgb\
:$BDD_HOME/VANESSA/Texture\
:$BDD_HOME/BDD_DREAM/Txt\
:$BDD_HOME/VESA_TEXTURE\
:$BDD_HOME/VESA_TEXTURE/sky_dusk\

OSG_OBJ=$BDD_HOME/RESSAC/\
:$BDD_HOME/VEHICULES/ive/\
:$BDD_HOME/DIVERS/Transport/\
:$BDD_HOME/DIVERS/Military/\
:$BDD_HOME/DIVERS/Agriculture\
:$BDD_HOME/DIVERS/Aicraft\
:$BDD_HOME/DIVERS/Airport\
:$BDD_HOME/DIVERS/Boundaries\
:$BDD_HOME/DIVERS/Commercial\
:$BDD_HOME/DIVERS/Communications\
:$BDD_HOME/DIVERS/Industrial\
:$BDD_HOME/DIVERS/Maritime\
:$BDD_HOME/DIVERS/Misc\
:$BDD_HOME/DIVERS/Power\
:$BDD_HOME/DIVERS/Residential\
:$BDD_HOME/DIVERS/Sport\
:$BDD_HOME/DIVERS/StreetFurniture\
:$BDD_HOME/DIVERS/Trees\
:$BDD_HOME/BLAGNAC_IVE/agt_LFBO\
:$BDD_HOME/RESSAC/\
:$BDD_HOME/BDD_DREAM/BDD/ive\
:$BDD_HOME/VANESSA/\
:$BDD_HOME/BLAGNAC/\
:$BDD_HOME/INSTRUMENT/\
:$BDD_HOME/MARIGNANE/\
:$BDD_HOME/MARSEILLE/\
:$BDD_HOME/MARSEILLE/marseillemipmaphard09dds_root_L0_X0_Y0\

OSG_FILE_PATH=$OSG_TEXTURE:$OSG_OBJ
OSG_NOTIFY_LEVEL=NOTICE
OSG_OPTIMIZER="DEFAULT ~MAKE_FAST_GEOMETRY"

export OSG_VERSION OSG_ROOT OSGDIR OSG_TEXTURE OSG_OBJ OSG_FILE_PATH OSG_NOTIFY_LEVEL OSG_OPTIMIZER

###################################################################
# QT
###

QT_VERSION=4
QT_ROOT=$PRO_HOME/QT$QT_VERSION
QTDIR=$QT_ROOT
QTEMBEDDEDDIR=$QT_ROOT/libembedded-widget

export QT_VERSION QT_ROOT QTDIR QTEMBEDDEDDIR

###################################################################
# Boost
###

BOOST_VERSION=1_45_0
BOOST_ROOT=$PRO_HOME/boost_$BOOST_VERSION/
BOOST_INCLUDEDIR=$PRO_HOME/boost_$BOOST_VERSION/
BOOST_LIBRARYDIR=$PRO_HOME/boost_$BOOST_VERSION/stage/lib/

export BOOST_VERSION BOOST_ROOT BOOST_INCLUDEDIR BOOST_LIBRARYDIR

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
# Tcl/tk
###

export PATH=/usr/local/ActiveTcl/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/ActiveTcl/lib:/usr/local/ActiveTcl/lib/itcl3.3:/usr/local/ActiveTcl/lib/itk3.3:$LD_LIBRARY_PATH

###################################################################
# Java 
###

JAVA_VERSION=1.6.0_31
JAVA_HOME=$PRO_HOME/jre/jre$JAVA_VERSION/
JAVAPATH=$JAVA_HOME/bin

export JAVA_VERSION JAVA_HOME JAVAPATH

###################################################################
# Global Variable
###

PATH=:$PATH\
:$ELIPS_HOME/bin\
:$JAVA_HOME/bin\
:$OSG_ROOT/bin\
:$QT_ROOT/bin\
:$TAO_ROOT/bin\
:$CERTI_HOME/bin

LD_LIBRARY_PATH=$LD_LIBRARY_PATH\
:$OSG_ROOT/lib\
:$OSG_ROOT/lib64\
:$QT_ROOT/lib\
:$TAO_ROOT/lib\
:/lib/\
:/usr/lib/\
:$CERTI_HOME/lib\
:$GENESIS_HOME/CERTI32/lib

MANPATH=$QT_ROOT/doc/man:$MANPATH

INSLIB=$TAO_ROOT/lib:$INSLIB

export PATH MANPATH LD_LIBRARY_PATH INSLIB

###################################################################
# Sourcing
###

source "$OSPL_HDE_ROOT/release.com"

###################################################################
# Other
###

# On active le traitement des commandes tierces avec xhost
xhost + > /dev/null 2>&1

###################################################################
