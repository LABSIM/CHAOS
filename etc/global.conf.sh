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
	if [ -f "/home/$(whoami)/dev/ELIPSTK/${ELIPS_SUBDIR}/script/switchenv.sh" ]; then 
		$(cd "/home/$(whoami)/dev/ELIPSTK/${ELIPS_SUBDIR}/script/" && sh "switchenv.sh" $1)
	fi
}


###################################################################
# Home path
###
 
PRO_HOME=/home/$(whoami)/Progiciels
CODES_HOME=/home/$(whoami)/CODES
BDD_HOME=/data/bdd

export PRO_HOME CODES_HOME BDD_HOME

###################################################################
# ELIPS 
###

ELIPS_HOME=/home/$(whoami)/dev/ELIPS/$ELIPS_SUBDIR
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

OSG_ROOT=$PRO_HOME/OSG-$OSG_VERSION
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

export OSG_ROOT OSGDIR OSG_TEXTURE OSG_OBJ OSG_FILE_PATH OSG_NOTIFY_LEVEL OSG_OPTIMIZER

###################################################################
# QT
###

QT_ROOT=$PRO_HOME/QT-$QT_VERSION
QTDIR=$QT_ROOT
QTINC=$QT_ROOT/include
QTLIB=$QT_ROOT/lib
QTEMBEDDEDDIR=$QT_ROOT/libembedded-widget

export QT_ROOT QTDIR QTINC QTLIB QTEMBEDDEDDIR

###################################################################
# Boost
###

BOOST_ROOT=$PRO_HOME/boost-$BOOST_VERSION
BOOST_INCLUDEDIR=$BOOST_ROOT/include
BOOST_LIBRARYDIR=$BOOST_ROOT/lib

export BOOST_ROOT BOOST_INCLUDEDIR BOOST_LIBRARYDIR

###################################################################
# Global Variable
###

PATH=$PATH\
:$ELIPS_HOME/bin\
:$OSG_ROOT/bin\
:$QT_ROOT/bin

LD_LIBRARY_PATH=$LD_LIBRARY_PATH\
:$OSG_ROOT/lib\
:$OSG_ROOT/lib64\
:$QT_ROOT/lib\
:/lib/\
:/usr/lib/

export PATH LD_LIBRARY_PATH

###################################################################
# Other
###

# On active le traitement des commandes tierces avec xhost
xhost + > /dev/null 2>&1

###################################################################
