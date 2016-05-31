#!/bin/bash

# export necessary env
export DEVTK_ROOT=$(readlink -f "$SCRIPTPATH/../../../")

###################################################################
# Versions deployment
###
if [ -f "$DEVTK_ROOT/script/linux/versions.sh" ]; then 
	source $DEVTK_ROOT/script/linux/versions.sh
else
	echo "Erreur dans la configuration de votre environment de travail... Contactez les administrateurs: Christian S. ou Nawfel K."
fi

# then simply source the entry point
source $DEVTK_ROOT/script/linux/entry/labsim.entry.sh

# == EOF
