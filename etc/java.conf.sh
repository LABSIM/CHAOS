#!/bin/bash

#######################
# java environment config
#
# Ce fichier defini les variables necessaires a la machine JAVA
#
# 07/02/12 - Kinani Nawfel
#######################

###################################################################
# Java 
###

JAVA_VERSION=1.6.0_31
JAVA_HOME=$PRO_HOME/jre/jre$JAVA_VERSION
JAVAPATH=$JAVA_HOME/bin

export JAVA_VERSION JAVA_HOME JAVAPATH

###################################################################
# Global Variable
###

PATH=$PATH\
:$JAVA_HOME/bin

export PATH
