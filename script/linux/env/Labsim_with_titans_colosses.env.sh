#!/bin/bash

##############################################################################
## Titans/Colosses LABSIM Development Environment config					##	
##																			##
## Ce fichier est inclu par le .bashrc lors de l'ouverture d'un terminal	##
##																			##
## 07/02/12 - Kinani Nawfel													##
##############################################################################

# Absolute path to this script
SCRIPT=$(readlink -f "$BASH_SOURCE")
# Absolute path this script is in
SCRIPTPATH=$(dirname "$SCRIPT")

##
# reminder - Labsim dev mask
##
# LABSIM_COMMON_MASK
# LABSIM_COLOSSES_MASK
# LABSIM_OLYMPIENS_MASK
# LABSIM_TITANS_MASK
# LABSIM_CONTRACT_MASK

# prefix 
source $SCRIPTPATH/../entry/labsim.prefix.sh

# export necessary env & declare our specific mask
export LABSIM_DEV_ID=$(( $LABSIM_COMMON_MASK ^ $LABSIM_TITANS_MASK ^ $LABSIM_COLOSSES_MASK ))

# postfix
source $SCRIPTPATH/../entry/labsim.postfix.sh

# == EOF
