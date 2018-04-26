#!/bin/bash

#
# GAIA : required LABSIM ground software ecosystem
# Copyright (C) 2012-2016  Nawfel KINANI
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; see the file COPYING.
# If not, see <http://www.gnu.org/licenses/>.
#

#######################
# HLA Gateway (BLADE, BLING, CERTI & GENESIS) environment config
#
# Ce fichier defini les variables necessaires codes CERTI & GENESIS
#
# 07/02/12 - Kinani Nawfel
#######################

###################################################################
# BLING
###
BLING_ROOT=$DEV_HOME/BLING
BLING_INCLUDEDIR=$BLING_ROOT/gateway/include
BLING_LIBRARYDIR=$BLING_ROOT/gateway/lib

export BLING_ROOT BLING_INCLUDEDIR BLING_LIBRARYDIR

###################################################################
# BLADE
###
BLADE_ROOT=$BLING_ROOT/extDep/Linux64/BLADE
BLADE_INCLUDEDIR=$BLADE_ROOT/include
BLADE_LIBRARYDIR=$BLADE_ROOT/lib

export BLADE_ROOT BLADE_INCLUDEDIR BLADE_LIBRARYDIR

###################################################################
# CERTI & GENESIS
###
GENESIS_VERSION=x86_64-linux2.6-centos
GENESIS_HOME=$CODES_HOME/genesis-$GENESIS_VERSION

CERTI_VERSION=3.4.2-dev1-x86_64-linux2.6-centos
CERTI_HOME=$CODES_HOME/certi-$CERTI_VERSION
CERTI_HTTP_PROXY=
CERTI_HOST=125.40.29.10
CERTI_UDP_PORT=24932
CERTI_TCP_PORT=24932

export GENESIS_VERSION GENESIS_HOME CERTI_VERSION CERTI_HOME CERTI_HTTP_PROXY CERTI_HOST CERTI_UDP_PORT CERTI_TCP_PORT

###################################################################
# Global Variable
###

PATH=$PATH\
:$CERTI_HOME/bin

LD_LIBRARY_PATH=$LD_LIBRARY_PATH\
:$CERTI_HOME/lib\
:$GENESIS_HOME/CERTI32/lib

export PATH LD_LIBRARY_PATH
