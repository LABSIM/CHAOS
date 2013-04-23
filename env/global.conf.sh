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
	if [ -f "~/dev/ELIPSTK/${ELIPS_SUBDIR}/script/switchenv.sh" ]; then 
		$(cd "~/dev/ELIPSTK/${ELIPS_SUBDIR}/script/switchenv.sh" && sh "switchenv.sh")
	fi
}


###################################################################
# Home path
###
 
PRO_HOME=~/Progiciels
CODES_HOME=~/CODES
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
