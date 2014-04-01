#!/bin/bash

#######################
# Developpement environment config
#
# Ce fichier contient l'ensemble des definitions
# pour les projets en cours de developpement
#
# 07/02/12 - Kinani Nawfel
#######################

###################################################################
# UTILITIES 
###

UTILITIES_ROOT=$DEV_HOME/Modeles/Utilities/$DEV_SUBDIR
UTILITIES_INCLUDEDIR=$UTILITIES_ROOT/include
UTILITIES_LIBRARYDIR=$UTILITIES_ROOT/lib

export UTILITIES_ROOT UTILITIES_INCLUDEDIR UTILITIES_LIBRARYDIR

###################################################################
# PROPTREE 
###

PROPTREE_ROOT=$DEV_HOME/Modeles/propTree/$DEV_SUBDIR
PROPTREE_INCLUDEDIR=$PROPTREE_ROOT/include
PROPTREE_LIBRARYDIR=$PROPTREE_ROOT/lib

export PROPTREE_ROOT PROPTREE_INCLUDEDIR PROPTREE_LIBRARYDIR

###################################################################
# HUD 
###

HUD_ROOT=$DEV_HOME/HUD/$DEV_SUBDIR
HUD_INCLUDEDIR=$HUD_ROOT/include
HUD_LIBRARYDIR=$HUD_ROOT/lib

export HUD_ROOT HUD_INCLUDEDIR HUD_LIBRARYDIR

###################################################################
# VESA 
###

VESA_ROOT=$DEV_HOME/VESA/$DEV_SUBDIR
VESA_INCLUDEDIR=$VESA_ROOT/include
VESA_LIBRARYDIR=$VESA_ROOT/lib
VESA_BINARYDIR=$VESA_ROOT/bin

export VESA_ROOT VESA_INCLUDEDIR VESA_LIBRARYDIR VESA_BINARYDIR

###################################################################
# ELIPS 
###

ELIPS_ROOT=$DEV_HOME/ELIPS/$DEV_SUBDIR
ELIPS_INCLUDEDIR=$(find -L ${ELIPS_ROOT}/include -type d | grep -v svn | grep -v VTB_QT)
ELIPS_INCLUDEDIR=$(echo -e "${ELIPS_ROOT}/build\n${ELIPS_INCLUDEDIR}" | tr '\n' ';')
ELIPS_LIBRARYDIR=$ELIPS_ROOT/lib
ELIPS_BINARYDIR=$ELIPS_ROOT/bin

ELIPSHOME=$ELIPS_ROOT	# backward compatibility
LC_NUMERIC=en_US

export ELIPS_ROOT ELIPS_INCLUDEDIR ELIPS_LIBRARYDIR ELIPS_BINARYDIR ELIPSHOME LC_NUMERIC

alias menage="$ELIPS_ROOT/etc/menage.sh"
alias cleanipc="$ELIPS_ROOT/etc/cleanipc.sh"
alias ELIPSutil="konqueror $ELIPS_ROOT/doc/html/PDF/ELIPS-RT2005_utilisateur.pdf"
alias VENUShelp="konqueror $ELIPS_ROOT/doc/html/PDF/VENUS-RT2005.pdf"
alias ELIPShelp="konqueror $ELIPS_ROOT/doc/html/index.html"

###################################################################
# ELIPS-TK
###

ELIPSTK_ROOT=$DEV_HOME/ELIPS-TK/$DEV_SUBDIR
ELIPSTK_INCLUDEDIR=$ELIPSTK_ROOT/include
ELIPSTK_LIBRARYDIR=$ELIPSTK_ROOT/lib
ELIPSTK_BINARYDIR=$ELIPSTK_ROOT/bin

export ELIPSTK_ROOT ELIPSTK_INCLUDEDIR ELIPSTK_LIBRARYDIR ELIPSTK_BINARYDIR

###################################################################
# ELIPS-DEMO
###

ELIPSDEMO_ROOT=$DEV_HOME/ELIPS-DEMO/$DEV_SUBDIR

export ELIPSDEMO_ROOT

###################################################################
# VISUEL PA 
###

IMAGE_PA_PATH=$BDD_HOME/IMAGE_PA

export IMAGE_PA_PATH

###################################################################
# Global Variable
###

PATH=$PATH\
:$VESA_BINARYDIR\
:$ELIPS_BINARYDIR

LD_LIBRARY_PATH=$LD_LIBRARY_PATH\
:$UTILITIES_LIBRARYDIR\
:$PROPTREE_LIBRARYDIR\
:$HUD_LIBRARYDIR\
:$VESA_LIBRARYDIR\
:$ELIPS_LIBRARYDIR

export PATH LD_LIBRARY_PATH

###################################################################
