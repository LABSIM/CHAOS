#!/usr/bin/perl -w

#
# OCEAN : a THETYS process's configuration file generator
# Copyright (C) 2015-2016 Nawfel KINANI
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program; see the files COPYING and COPYING.LESSER.
# If not, see <http://www.gnu.org/licenses/>.
#

# package
package Ocean::default;

# perl version
use 5.024;

# force declaration, warnings & print error diagnostics
use strict;
use warnings;
use diagnostics;

BEGIN {
	
    require Exporter;
    
    # set the version for version checking
    our $VERSION     = 1.00;
    
    # Inherit from Exporter to export functions and variables
    our @ISA         = qw(Exporter);
    
    # Functions and variables which are exported by default
    #our @EXPORT      = "";
    
    # Functions and variables which can be optionally exported
    our @EXPORT_OK   = qw(
    	$OCEAN_ROOT 
    	$TEMPLATE_PATH 
    	$SCRIPT_PATH
		$FRONTEND_CXX_TEMPLATE_PATH 
		$CMAKE_TEMPLATE_PATH
		$PROTO_TEMPLATE_PATH 
		$PARSER_PATH
		$TMP_PATH
	);
    
}  

use FindBin qw($Bin $Script);

# ------------------------------------
# OCEAN default configuration package
# ------------------------------------
#
# Ce fichier contient l'ensemble des variables 
# necéssaires au bon fonctionnement des scripts
#
# author : 	Nawfel Kinani
# creation: 23/02/15
# group : 	Onera DCSD/PSEV LabSim
#

# Création du root path
our $OCEAN_ROOT = $FindBin::Bin."/..";

# Création des paths par defaut - readonly
our $TEMPLATE_PATH					= $OCEAN_ROOT."/template";
our $SCRIPT_PATH					= $OCEAN_ROOT."/script";
our $FRONTEND_CXX_TEMPLATE_PATH		= $TEMPLATE_PATH."/frontend/cxx";
our $CMAKE_TEMPLATE_PATH			= $TEMPLATE_PATH."/cmake";
our $PROTO_TEMPLATE_PATH			= $TEMPLATE_PATH."/proto";
our $PARSER_PATH					= $SCRIPT_PATH."/parser";
our $TMP_PATH						= $OCEAN_ROOT."/tmp";

# end module
1;
__END__
