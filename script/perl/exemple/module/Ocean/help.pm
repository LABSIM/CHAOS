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
package Ocean::help;

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
    #our @EXPORT_OK   =  qw(PrintHeader PrintWorkflow PrintUsage PrintDetailedOpt PrintVersion PrintFullHelp);
    
}  

# ------------------------------------
# OCEAN help package
# ------------------------------------
#
# Ce fichier contient les fonctions d'affichage de l'aide
#
# author : 	Nawfel Kinani
# création: 23/02/15
# group : 	Onera DCSD/PSEV LabSim
#

# end module
1;
__END__

=head1 NAME
 
OCEAN : a THETYS process's configuration file generator                      
 
=head1 SYNOPSIS
 
ocean [options]
 
 Options:
   --experiment-dir|e'  	input actor experiment directory
   --project-dir|p'     	output simulation project directory
   --frontend|no-frontend'	activate/deactivate frontend project generation mode
   --backend|no-backend'	activate/deactivate backend project generation mode
   --debug|no-debug'    	keep intermediate tmp/ directory
   --dump|no-dump'     		log internal variables state
   --help|h'           		brief help message			
   --man                	full documentation
   
=head1 OPTIONS
 
=over 4

=item B<-e, --experiment-dir> I<[REQUIRED]>

The shared input simulation experiment directory containing the XML actor configuration files => SLU (Sequential Logic Unit), HCU (Hardwire Control Unit) & ALU(s) (Arithmetic Logic Unit).
 
=item B<-p, --project-dir> I<[REQUIRED]>

The actual output simulation project directory. Depending on ALU properties, it will generate the THETYS required frontend model & backend actor depending on current option.

=item B<--debug, --no-debug> I<[DEBUG]>

Save current working tmp directory, mainly for debugging

=item B<--dump, --no-dump> I<[DEBUG]>

Print current internal variables state, mainly for debugging

=item B<-h, --help> 
 
Print a brief help message and exits.
 
=item B<--man>
 
Prints the manual page and exits.
 
=back

=head1 EXIT STATUS

=over 4

=item B<0>

if OK

=item B<1>

if minor problems (e.g., cannot access subdirectory)

=item B<2>

if serious trouble (e.g., cannot access command-line argument)
  
=back

=head1 DESCRIPTION

B<This program> will read the given input ALU file(s) and generate necessary THETYS model frontend & backend file(s) into the given output simulation project directory
	
=head1 COPYRIGHT

Copyright (C) 2015-2017 Nawfel KINANI              
This program comes with ABSOLUTELY NO WARRANTY This is free software, and you are welcome to redistribute under certain conditions
 
=cut
