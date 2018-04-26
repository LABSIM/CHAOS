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
package Ocean::procedure;

# required
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
    	PreConfigure 
    	Parse 
    	Stage 
    	Scale 
    	PostConfigure
    );
    
}   

# Ocean packages
use lib qw(../../module);
use Ocean::function; 
use Ocean::procedure::parsing;
use Ocean::procedure::staging;
use Ocean::procedure::scaling;

# ------------------------------------
# OCEAN Procedure package
# ------------------------------------
#
# Ce fichier contient l'ensemble des routines haut niveau
#
# author : 	Nawfel Kinani
# creation: 23/02/15
# group : 	Onera DCSD/PSEV LabSim
#

sub PreConfigure {
	
	# first parse argument 
	Ocean::function::ProcessCommandLineOptions();
	
	# Status
	print "====[ Pre-configuring ]====\n";
	
	print "<< build hashes >>\n"; 
	Ocean::function::BuildHashes();
	Ocean::function::DumpVar();
	
	print "<< validate origin consistency >>\n"; 
	Ocean::function::ValidateOrigin();
	Ocean::function::DumpVar();
	
} # PreConfigure()

sub Parse {
	
	# Status
	print "====[ Parsing : OCEAN << IN Colosse ALU xml files ]====\n";
	
	print "<< XML Parsing >>\n";
	Ocean::procedure::parsing::XML();
	Ocean::function::DumpVar();

} # Parse()

sub Stage {
	
	# Status
	print "====[ Staging : OCEAN >> configured autogen source files from OCEAN template ] ]====\n";
	
	print "<< PROTO Staging >>\n";
	Ocean::procedure::staging::PROTO();
	Ocean::function::DumpVar();
	
	print "<< CMAKE Staging >>\n";
	Ocean::procedure::staging::CMAKE();
	Ocean::function::DumpVar();
	
	print "<< STUB Staging >>\n";
	Ocean::procedure::staging::STUB();
	Ocean::function::DumpVar();
	
} # Stage()

sub Scale {				
	
	# Status
	print "====[ Scaling : OCEAN >> copying stage files to requested install directory ]====\n";
		
	print "<< PROTO Scaling >>\n";
	Ocean::procedure::scaling::PROTO();
	Ocean::function::DumpVar();
	
	print "<< CMAKE Scaling >>\n";
	Ocean::procedure::scaling::CMAKE();
	Ocean::function::DumpVar();
	
	print "<< STUB Scaling >>\n";
	Ocean::procedure::scaling::STUB();
	Ocean::function::DumpVar();
	
} # Scale()

sub PostConfigure {
	
	# Status
	print "====[ Post-Configuring ]====\n";
	
	print "<< removing temporary folder >>\n";	
	Ocean::function::RemoveTemporaryTree();	
	Ocean::function::DumpVar();
		
	print "\n";
		
} # PostConfigure()

# end module
1;
__END__

