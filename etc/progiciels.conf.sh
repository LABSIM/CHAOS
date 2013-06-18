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
if [ ! -d $OSG_ROOT ]; then 
	OSG_ROOT=$PRO_HOME/OSG
fi

OSG_INCLUDEDIR=$OSG_ROOT/include
OSG_LIBRARYDIR=$OSG_ROOT/lib64
OSG_BINARYDIR=$OSG_ROOT/bin

OSG_BDT=${BDD_HOME}/Bdt/
for path in $(find -L ${OSG_BDT} -maxdepth 1 -type d ! -name Bdt); do
	OSG_BDT=$OSG_BDT:$path
done

OSG_TEXTURE=${BDD_HOME}/Texture/
for path in $(find -L ${OSG_TEXTURE} -type d ! -name Texture); do
	OSG_TEXTURE=$OSG_TEXTURE:$path
done

OSG_DYNAMIC=${BDD_HOME}/Dynamic/
for path in $(find -L ${OSG_DYNAMIC} -type d ! -name Dynamic); do
	OSG_DYNAMIC=$OSG_DYNAMIC:$path
done

OSG_STATIC=${BDD_HOME}/Static/
for path in $(find -L ${OSG_STATIC} -type d ! -name Static); do
	OSG_STATIC=$OSG_STATIC:$path
done

OSG_FILE_PATH=$OSG_BDT:$OSG_TEXTURE:$OSG_DYNAMIC:$OSG_STATIC:$BDD_HOME/INSTRUMENT:$BDD_HOME/IMAGES_PA
OSG_NOTIFY_LEVEL=NOTICE
OSG_OPTIMIZER="DEFAULT ~MAKE_FAST_GEOMETRY"

export OSG_ROOT OSG_INCLUDEDIR OSG_LIBRARYDIR OSG_BINARYDIR OSG_BDT OSG_TEXTURE OSG_DYNAMIC OSG_STATIC OSG_FILE_PATH OSG_NOTIFY_LEVEL OSG_OPTIMIZER

###################################################################
# QT
###

QT_ROOT=$PRO_HOME/QT-$QT_VERSION

# alternative (normally koffi only)
if [ ! -d $QT_ROOT ]; then 
	QT_ROOT=$PRO_HOME/QT4
fi

QT_INCLUDEDIR=$QT_ROOT/include
QT_LIBRARYDIR=$QT_ROOT/lib
QT_BINARYDIR=$QT_ROOT/bin

QTEMBEDDED_ROOT=$QT_ROOT/libembedded-widget
QTEMBEDDED_INCLUDEDIR=$QTEMBEDDED_ROOT/include
QTEMBEDDED_LIBRARYDIR=$QTEMBEDDED_ROOT/lib

export QT_ROOT QT_INCLUDEDIR QT_LIBRARYDIR QT_BINARYDIR QTEMBEDDED_ROOT QTEMBEDDED_INCLUDEDIR QTEMBEDDED_LIBRARYDIR

###################################################################
# Boost
###

BOOST_ROOT=$PRO_HOME/boost-$BOOST_VERSION

# alternative (normally koffi only)
if [ ! -d $BOOST_ROOT ]; then 
	BOOST_ROOT=$PRO_HOME/boost_1_45_0
	BOOST_LIBRARYDIR=$BOOST_ROOT/stage/lib
	BOOST_INCLUDEDIR=$BOOST_ROOT/
else
	BOOST_LIBRARYDIR=$BOOST_ROOT/lib
	BOOST_INCLUDEDIR=$BOOST_ROOT/include
fi

export BOOST_ROOT BOOST_INCLUDEDIR BOOST_LIBRARYDIR

###################################################################
# Global Variable
###

# prepone the new QT to inhibit the installed one 
# & postpone others progiciels
PATH=$QT_ROOT/bin\
:$PATH\
:$OSG_ROOT/bin\

LD_LIBRARY_PATH=$LD_LIBRARY_PATH\
:$OSG_ROOT/lib\
:$OSG_ROOT/lib64\
:$QT_ROOT/lib

export PATH LD_LIBRARY_PATH

###################################################################
