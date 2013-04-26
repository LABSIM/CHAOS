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

OSGDIR=$OSG_ROOT
OSGINCDIR=$OSG_ROOT/include

for path in $(find -L ${BDD_HOME}/bdt/ -maxdepth 1 -type d); do
	OSG_BDD=$path:$OSG_BDD
done

for path in $(find -L ${BDD_HOME}/texture/ -type d); do
	OSG_TEXTURE=$path:$OSG_TEXTURE
done

for path in $(find -L ${BDD_HOME}/mobile/ -type d); do
	OSG_MOBILE=$path:$OSG_MOBILE
done

for path in $(find -L ${BDD_HOME}/static/ -type d); do
	OSG_STATIC=$path:$OSG_STATIC
done

OSG_FILE_PATH=$OSG_BDD:$OSG_TEXTURE:$OSG_MOBILE:$OSG_STATIC
OSG_NOTIFY_LEVEL=NOTICE
OSG_OPTIMIZER="DEFAULT ~MAKE_FAST_GEOMETRY"

export OSG_ROOT OSGDIR OSGINC OSG_TEXTURE OSG_OBJ OSG_FILE_PATH OSG_NOTIFY_LEVEL OSG_OPTIMIZER

###################################################################
# QT
###

QT_ROOT=$PRO_HOME/QT-$QT_VERSION

# alternative (normally koffi only)
if [ ! -d $QT_ROOT ]; then 
	QT_ROOT=$PRO_HOME/QT4
fi

QTDIR=$QT_ROOT
QTINC=$QT_ROOT/include
QTLIB=$QT_ROOT/lib

QTEMBEDDED_ROOT=$QT_ROOT/libembedded-widget
QTEMBEDDED_INCLUDEDIR=$QTEMBEDDED_ROOT/include
QTEMBEDDED_LIBRARYDIR=$QTEMBEDDED_ROOT/lib

export QT_ROOT QTDIR QTINC QTLIB QTEMBEDDED_ROOT QTEMBEDDED_INCLUDEDIR QTEMBEDDED_LIBRARYDIR

###################################################################
# Boost
###

BOOST_ROOT=$PRO_HOME/boost-$BOOST_VERSION


# alternative (normally koffi only)
if [ ! -d $BOOST_ROOT ]; then 
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

# prepone the new QT to inhibit the installed one 
# & postpone others progiciels
PATH=$QT_ROOT/bin\
:$PATH\
:$OSG_ROOT/bin\


LD_LIBRARY_PATH=$LD_LIBRARY_PATH\
:$OSG_ROOT/lib\
:$OSG_ROOT/lib64\
:$QT_ROOT/lib\
:/lib/\
:/usr/lib/

export PATH LD_LIBRARY_PATH

###################################################################
