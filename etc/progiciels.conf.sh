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
# MPC
###

MPC_ROOT=$PRO_HOME/mpc-$MPC_VERSION
MPC_LIBRARYDIR=$MPC_ROOT/lib
MPC_INCLUDEDIR=$MPC_ROOT/include

export MPC_ROOT MPC_LIBRARYDIR MPC_INCLUDEDIR

###################################################################
# MPFR
###

MPFR_ROOT=$PRO_HOME/mpfr-$MPFR_VERSION
MPFR_LIBRARYDIR=$MPFR_ROOT/lib
MPFR_INCLUDEDIR=$MPFR_ROOT/include

export MPFR_ROOT MPFR_LIBRARYDIR MPFR_INCLUDEDIR

###################################################################
# GMP
###

GMP_ROOT=$PRO_HOME/gmp-$GMP_VERSION
GMP_LIBRARYDIR=$GMP_ROOT/lib
GMP_INCLUDEDIR=$GMP_ROOT/include

export GMP_ROOT GMP_LIBRARYDIR GMP_INCLUDEDIR

###################################################################
# AutoGen
###

AUTOGEN_ROOT=$PRO_HOME/autogen-$AUTOGEN_VERSION
AUTOGEN_BINARYDIR=$AUTOGEN_ROOT/bin
AUTOGEN_LIBRARYDIR=$AUTOGEN_ROOT/lib
AUTOGEN_INCLUDEDIR=$AUTOGEN_ROOT/include

export AUTOGEN_ROOT AUTOGEN_BINARYDIR AUTOGEN_LIBRARYDIR AUTOGEN_INCLUDEDIR

###################################################################
# GCC
###

GCC_ROOT=$PRO_HOME/gcc-$GCC_VERSION
GCC_BINARYDIR=$GCC_ROOT/bin
GCC_LIBRARYDIR=$GCC_ROOT/lib
GCC_LIBRARY64DIR=$GCC_ROOT/lib64
GCC_LIBRARYEXECDIR=$GCC_ROOT/libexec/gcc-$GCC_VERSION/x86_64-unknown-linux-gnu/$GCC_VERSION
GCC_INCLUDEDIR=$GCC_ROOT/include

CC=$GCC_BINARYDIR/gcc
CXX=$GCC_BINARYDIR/g++

export GCC_ROOT GCC_BINARYDIR GCC_LIBRARYDIR GCC_LIBRARY64DIR GCC_LIBRARYEXECDIR GCC_INCLUDEDIR CC CXX

###################################################################
# CMake/Ctest/CPack
###

CMAKE_ROOT=$PRO_HOME/cmake-$CMAKE_VERSION
CMAKE_BINARYDIR=$CMAKE_ROOT/bin
CMAKE_MODULE_PATH=$CMAKE_ROOT/share/cmake-$CMAKE_MAJ_VER.$CMAKE_MIN_VER/Modules

export CMAKE_ROOT CMAKE_BINARYDIR CMAKE_MODULE_PATH

###################################################################
# Boost
###

BOOST_ROOT=$PRO_HOME/boost-$BOOST_VERSION
BOOST_LIBRARYDIR=$BOOST_ROOT/lib
BOOST_INCLUDEDIR=$BOOST_ROOT/include

export BOOST_ROOT BOOST_INCLUDEDIR BOOST_LIBRARYDIR

###################################################################
# Nvidia Texture Tools
###

NVTT_ROOT=$PRO_HOME/nvidia-texture-tools-$NVTT_VERSION
NVTT_BINARYDIR=$NVTT_ROOT/bin
NVTT_LIBRARYDIR=$NVTT_ROOT/lib
NVTT_INCLUDEDIR=$NVTT_ROOT/include

export NVTT_ROOT NVTT_BINARYDIR NVTT_LIBRARYDIR NVTT_INCLUDEDIR

###################################################################
# OpenSceneGraph
###

OSG_ROOT=$PRO_HOME/OSG-$OSG_VERSION
OSG_INCLUDEDIR=$OSG_ROOT/include
OSG_LIBRARY64DIR=$OSG_ROOT/lib64
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
# CEGUI
###

CEGUI_ROOT=$PRO_HOME/cegui-$CEGUI_VERSION
CEGUI_BINARYDIR=$CEGUI_ROOT/bin
CEGUI_LIBRARYDIR=$CEGUI_ROOT/lib
CEGUI_INCLUDEDIR=$CEGUI_ROOT/include

export CEGUI_ROOT CEGUI_BINARYDIR CEGUI_LIBRARYDIR CEGUI_INCLUDEDIR

###################################################################
# QT
###

QT_ROOT=$PRO_HOME/QT-$QT_VERSION
QT_INCLUDEDIR=$QT_ROOT/include
QT_LIBRARYDIR=$QT_ROOT/lib
QT_BINARYDIR=$QT_ROOT/bin

QTEMBEDDED_ROOT=$QT_ROOT/libembedded-widget
QTEMBEDDED_INCLUDEDIR=$QTEMBEDDED_ROOT/include
QTEMBEDDED_LIBRARYDIR=$QTEMBEDDED_ROOT/lib

QTDIR=$QT_ROOT
QTINC=$QT_INCLUDEDIR
QTLIB=$QT_LIBRARYDIR

export QT_ROOT QT_INCLUDEDIR QT_LIBRARYDIR QT_BINARYDIR QTEMBEDDED_ROOT QTEMBEDDED_INCLUDEDIR QTEMBEDDED_LIBRARYDIR QTDIR QTINC QTLIB


###################################################################
# Leap Motion SDK
###

LEAPMOTION_ROOT=$PRO_HOME/Leap_Developer_Kit_$LEAPMOTION_VERSION
LEAPMOTION_LIBRARYDIR=$LEAPMOTION_ROOT/LeapSDK/lib
LEAPMOTION_INCLUDEDIR=$LEAPMOTION_ROOT/LeapSDK/include

export LEAPMOTION_ROOT LEAPMOTION_LIBRARYDIR LEAPMOTION_INCLUDEDIR

###################################################################
# Global Variable
###


#################
# GCC Variables #
#################
export PATH=/home/nkinani/Progiciels/gcc-$GCC_VERSION/bin:/home/nkinani/Progiciels/gcc-$GCC_VERSION/libexec/gcc-4.7.2/x86_64-unknown-linux-gnu/4.7.2:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH
export LD_LIBRARY_PATH=/home/nkinani/Progiciels/gcc-$GCC_VERSION/lib64:/home/nkinani/Progiciels/gcc-$GCC_VERSION/lib:/lib:/lib64:/usr/lib:/usr/lib64:$LD_LIBRARY_PATH
export CC=/home/nkinani/Progiciels/gcc-$GCC_VERSION/bin/gcc
export CXX=/home/nkinani/Progiciels/gcc-$GCC_VERSION/bin/g++


# prepone the new GCC to inhibit the installed one 
# & postpone others progiciels
PATH=$GCC_BINARYDIR\
:$GCC_LIBRARYEXECDIR\
:$CMAKE_BINARYDIR\
:$PATH\
:$AUTOGEN_BINARYDIR\
:$NVTT_BINARYDIR\
:$OSG_BINARYDIR\
:$CEGUI_BINARYDIR

LD_LIBRARY_PATH=$GCC_LIBRARYDIR\
:$GCC_LIBRARY64DIR\
:$LD_LIBRARY_PATH\
:$MPC_LIBRARYDIR\
:$MPFR_LIBRARYDIR\
:$GMP_LIBRARYDIR\
:$AUTOGEN_LIBRARYDIR\
:$OSG_LIBRARYDIR\
:$BOOST_LIBRARYDIR\
:$NVTT_LIBRARYDIR\
:$CEGUI_LIBRARYDIR\
:$LEAPMOTION_LIBRARYDIR

export PATH LD_LIBRARY_PATH

###################################################################
