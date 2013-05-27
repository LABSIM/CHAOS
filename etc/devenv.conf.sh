#!/bin/bash

#######################
# Developpment environment application support config
#
# Ce fichier defini les variables necessaires a configuration de lénvironment de developement logiciel
#
# 07/02/12 - Kinani Nawfel
#######################

###################################################################
# Eclipse IDE configuration
###

ECLIPSE_HOME=$DEVENV_HOME/eclipse-$ECLIPSE_VERSION

export ECLIPSE_VERSION ECLIPSE_HOME

###################################################################
# Java Runtime Environment configuration
###

JAVA_HOME=$DEVENV_HOME/jre/jre$JAVA_VERSION
JAVAPATH=$JAVA_HOME/bin

export JAVA_VERSION JAVA_HOME JAVAPATH

###################################################################
# Global Variable
###

PATH=$PATH\
:$JAVA_HOME/bin

export PATH
