#!/bin/bash

#######################
# Progiciels environment config
#
# Ce fichier defini les variables necessaires aux 
# different Progiciels 
#
# 07/02/12 - Kinani Nawfel
#######################

###################################################################
# OpenSceneGraph
###

OSG_ROOT=$PRO_HOME/OSG-$OSG_VERSION

# alternative (normally koffi only)
if [ -d $OSG_ROOT ]; then 
	OSG_ROOT=$PRO_HOME/OSG
fi

OSGDIR=$OSG_ROOT
OSGINCDIR=$OSG_ROOT/include

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
:$BDD_HOME/Iser/\
:$BDD_HOME/MARIGNANE/\
:$BDD_HOME/MARSEILLE/\
:$BDD_HOME/MARSEILLE/marseillemipmaphard09dds_root_L0_X0_Y0\

OSG_FILE_PATH=$OSG_TEXTURE:$OSG_OBJ
OSG_NOTIFY_LEVEL=NOTICE
OSG_OPTIMIZER="DEFAULT ~MAKE_FAST_GEOMETRY"

export OSG_ROOT OSGDIR OSGINC OSG_TEXTURE OSG_OBJ OSG_FILE_PATH OSG_NOTIFY_LEVEL OSG_OPTIMIZER

###################################################################
# QT
###

QT_ROOT=$PRO_HOME/QT-$QT_VERSION

# alternative (normally koffi only)
if [ -d $QT_ROOT ]; then 
	QT_ROOT=$PRO_HOME/QT4
fi

QTDIR=$QT_ROOT
QTINC=$QT_ROOT/include
QTLIB=$QT_ROOT/lib
QTEMBEDDEDDIR=$QT_ROOT/libembedded-widget

export QT_ROOT QTDIR QTINC QTLIB QTEMBEDDEDDIR

###################################################################
# Boost
###

BOOST_ROOT=$PRO_HOME/boost-$BOOST_VERSION


# alternative (normally koffi only)
if [ -d $BOOST_ROOT ]; then 
	BOOST_ROOT=$PRO_HOME/boost_1_45_0
	BOOST_LIBRARYDIR=$BOOST_ROOT/stage/lib
else
	BOOST_LIBRARYDIR=$BOOST_ROOT/lib
fi

BOOST_INCLUDEDIR=$BOOST_ROOT/include
BOOSTINC=$BOOST_INCLUDEDIR

export BOOST_ROOT BOOST_INCLUDEDIR BOOST_LIBRARYDIR BOOSTINC

###################################################################
# Global Variable
###

PATH=$PATH\
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
