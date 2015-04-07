#!/bin/bash

# export necessary env
export DEVTK_ROOT=$(readlink -f "$SCRIPTPATH/../../../")

# don't forget to simply source the local version bash file 
source $DEVTK_ROOT/conf/versions.sh

# then simply source the entry point
source $DEVTK_ROOT/script/linux/entry/labsim.entry.sh

# == EOF
