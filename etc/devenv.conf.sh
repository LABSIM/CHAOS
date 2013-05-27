#!/bin/bash

#######################
# Developpment environment application support config
#
# Ce fichier defini les variables necessaires a configuration de l'environment de developement logiciel (IDE, web & mail ...)
#
# 07/02/12 - Kinani Nawfel
#######################

###################################################################
# Eclipse IDE configuration
###

ECLIPSE_HOME=$DEVENV_HOME/eclipse-$ECLIPSE_VERSION

export ECLIPSE_HOME

###################################################################
# Firefox configuration
###

FIREFOX_HOME=$DEVENV_HOME/firefox

export FIREFOX_HOME

###################################################################
# Thunderbird configuration
###

THUNDERBIRD_HOME=$DEVENV_HOME/thunderbird

export THUNDERBIRD_HOME

###################################################################
# Java Runtime Environment configuration
###

JAVA_HOME=$DEVENV_HOME/jre/jre$JAVA_VERSION
JAVAPATH=$JAVA_HOME/bin

export JAVA_HOME

###################################################################
# Global Variable
###

PATH=$PATH\
:$JAVA_HOME/bin

export PATH
