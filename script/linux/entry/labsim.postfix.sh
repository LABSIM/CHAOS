#!/bin/bash

# export necessary env
export DEVTK_ROOT=$(readlink -f "$SCRIPTPATH/../../../")

# then simply source the entry point
source $DEVTK_ROOT/script/linux/entry/labsim.entry.sh

# == EOF
