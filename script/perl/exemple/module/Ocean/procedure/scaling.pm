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
package Ocean::procedure::scaling;

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
    our @EXPORT_OK   =  qw(PROTO CMAKE STUB);
    
}  

# OCEAN package
use lib qw(../../../module);
use Ocean::system; 
use Ocean::var;
use Ocean::function;

# useful package
use IPC::System::Simple;
use XML::SimpleObject::LibXML;
use Switch;

# ------------------------------------
# OCEAN Scaling package
# ------------------------------------
#
# Ce fichier contient l'ensemble des routines de dispatch des fichiers de sorties du deployment
#
# author : 	Nawfel Kinani
# creation: 24/02/15
# group : 	Onera DCSD/PSEV LabSim
#

sub PROTO_Frontend {
	
	# iterate over each model
	FRONTEND: for my $frontend_ref ( @{ $Ocean::var::g__Labsim_files_properties{Frontend} } ) {
		
		# scaling recquirements test
		FRONTEND_SCALING_RECQUIREMENTS_TEST: {
			
			for my $model_ref ( @{ $Ocean::var::g__Labsim_simulation_properties{SLU}{Participant}{Model} } ) {
				
				if( $model_ref->{ALUAlias} eq $frontend_ref->{Alias} ) {
				
					for my $sink_ref ( @{ $Ocean::var::g__Labsim_simulation_properties{HCU}{Sink} } ) {
						
						if( $model_ref->{SinkAlias} eq $sink_ref->{Alias} ) {
							
							if( $sink_ref->{NetworkInterfaceAddress} eq Ocean::system::NetworkInterfaceAddress()) {
								
								# print
								print "\t[recquirements] frontend : ".$frontend_ref->{Alias}." ; OK. scale !\n";
						
								# OK ! finally found it
								last FRONTEND_SCALING_RECQUIREMENTS_TEST;
								
							} # if()
							
						} # if() 
						
					} # for()
					
				} # if() 
			
			} # for()
			
			# print
			print "\t[recquirements] frontend : ".$frontend_ref->{Alias}." ; FAIL. skip !\n";
								
			# if this point is reached, then scaling recquirements have not met so... neeeext :)
			next FRONTEND;
			
		} # FRONTEND_SCALING_RECQUIREMENTS_TEST
		
		# copy !
			
		Ocean::system::CopyFile($frontend_ref->{Proto}{Temporary},$frontend_ref->{Proto}{Destination});
		
		# ckeck !
			
		Ocean::system::CheckFile($frontend_ref->{Proto}{Destination});
	
	} # for()
	
}; # PROTO_Frontend()

sub PROTO_Backend {
	
	# iterate over each model
	BACKEND: for my $backend_ref ( @{ $Ocean::var::g__Labsim_files_properties{Backend} } ) {
		
		# scaling recquirements test
		BACKEND_SCALING_RECQUIREMENTS_TEST: {
			
			for my $actor_ref ( @{ $Ocean::var::g__Labsim_simulation_properties{SLU}{Participant}{Actor} } ) {
				
				if( $actor_ref->{ALUAlias} eq $backend_ref->{Alias} ) {
				
					for my $sink_ref ( @{ $Ocean::var::g__Labsim_simulation_properties{HCU}{Sink} } ) {
						
						if( $actor_ref->{SinkAlias} eq $sink_ref->{Alias} ) {
							
							if( $sink_ref->{NetworkInterfaceAddress} eq Ocean::system::NetworkInterfaceAddress()) {
								
								# print
								print "\t[recquirements] frontend : ".$backend_ref->{Alias}." ; OK. scale !\n";
						
								# OK ! finally found it
								last BACKEND_SCALING_RECQUIREMENTS_TEST;
								
							} # if()
							
						} # if() 
						
					} # for()
					
				} # if() 
			
			} # for()
			
			# print
			print "\t[recquirements] frontend : ".$backend_ref->{Alias}." ; FAIL. skip !\n";
								
			# if this point is reached, then scaling recquirements have not met so... neeeext :)
			next BACKEND;
			
		} # BACKEND_SCALING_RECQUIREMENTS_TEST
		
		# copy !
			
		Ocean::system::CopyFile($backend_ref->{Proto}{Temporary},$backend_ref->{Proto}{Destination});
		
		# ckeck !
			
		Ocean::system::CheckFile($backend_ref->{Proto}{Destination});
		
	} # for()
		
}; # PROTO_Backend()

sub PROTO {
	
	PROTO_Frontend();
	PROTO_Backend();
	
}; # PROTO()

sub CMAKE_Frontend {
	
	# iterate over each model
	FRONTEND: for my $frontend_ref ( @{ $Ocean::var::g__Labsim_files_properties{Frontend} } ) {
		
		# scaling recquirements test
		FRONTEND_SCALING_RECQUIREMENTS_TEST: {
			
			for my $model_ref ( @{ $Ocean::var::g__Labsim_simulation_properties{SLU}{Participant}{Model} } ) {
				
				if( $model_ref->{ALUAlias} eq $frontend_ref->{Alias} ) {
				
					for my $sink_ref ( @{ $Ocean::var::g__Labsim_simulation_properties{HCU}{Sink} } ) {
						
						if( $model_ref->{SinkAlias} eq $sink_ref->{Alias} ) {
							
							if( $sink_ref->{NetworkInterfaceAddress} eq Ocean::system::NetworkInterfaceAddress()) {
								
								# print
								print "\t[recquirements] frontend : ".$frontend_ref->{Alias}." ; OK. scale !\n";
						
								# OK ! finally found it
								last FRONTEND_SCALING_RECQUIREMENTS_TEST;
								
							} # if()
							
						} # if() 
						
					} # for()
					
				} # if() 
			
			} # for()
			
			# print
			print "\t[recquirements] frontend : ".$frontend_ref->{Alias}." ; FAIL. skip !\n";
								
			# if this point is reached, then scaling recquirements have not met so... neeeext :)
			next FRONTEND;
			
		} # FRONTEND_SCALING_RECQUIREMENTS_TEST
		
		# copy !
			
		Ocean::system::CopyFile($frontend_ref->{CMake}{Temporary},$frontend_ref->{CMake}{Destination});
		
		# ckeck !
			
		Ocean::system::CheckFile($frontend_ref->{CMake}{Destination});
	
	} # for()

}; # CMAKE_Frontend()

sub CMAKE_Backend {

	# iterate over each model
	BACKEND: for my $backend_ref ( @{ $Ocean::var::g__Labsim_files_properties{Backend} } ) {
		
		# scaling recquirements test
		BACKEND_SCALING_RECQUIREMENTS_TEST: {
			
			for my $actor_ref ( @{ $Ocean::var::g__Labsim_simulation_properties{SLU}{Participant}{Actor} } ) {
				
				if( $actor_ref->{ALUAlias} eq $backend_ref->{Alias} ) {
				
					for my $sink_ref ( @{ $Ocean::var::g__Labsim_simulation_properties{HCU}{Sink} } ) {
						
						if( $actor_ref->{SinkAlias} eq $sink_ref->{Alias} ) {
							
							if( $sink_ref->{NetworkInterfaceAddress} eq Ocean::system::NetworkInterfaceAddress()) {
								
								# print
								print "\t[recquirements] frontend : ".$backend_ref->{Alias}." ; OK. scale !\n";
						
								# OK ! finally found it
								last BACKEND_SCALING_RECQUIREMENTS_TEST;
								
							} # if()
							
						} # if() 
						
					} # for()
					
				} # if() 
			
			} # for()
			
			# print
			print "\t[recquirements] frontend : ".$backend_ref->{Alias}." ; FAIL. skip !\n";
								
			# if this point is reached, then scaling recquirements have not met so... neeeext :)
			next BACKEND;
			
		} # BACKEND_SCALING_RECQUIREMENTS_TEST
		
		# copy !
			
		Ocean::system::CopyFile($backend_ref->{CMake}{Temporary},$backend_ref->{CMake}{Destination});
		
		# ckeck !
			
		Ocean::system::CheckFile($backend_ref->{CMake}{Destination});
		
	} # for()
	
}; # CMAKE_Backend()

sub CMAKE {

	CMAKE_Frontend();
	CMAKE_Backend();
	
}; # CMAKE()

sub STUB_Frontend {

	# iterate over each model
	FRONTEND: for my $frontend_ref ( @{ $Ocean::var::g__Labsim_files_properties{Frontend} } ) {
		
		# scaling recquirements test
		FRONTEND_SCALING_RECQUIREMENTS_TEST: {
			
			for my $model_ref ( @{ $Ocean::var::g__Labsim_simulation_properties{SLU}{Participant}{Model} } ) {
				
				if( $model_ref->{ALUAlias} eq $frontend_ref->{Alias} ) {
				
					for my $sink_ref ( @{ $Ocean::var::g__Labsim_simulation_properties{HCU}{Sink} } ) {
						
						if( $model_ref->{SinkAlias} eq $sink_ref->{Alias} ) {
							
							if( $sink_ref->{NetworkInterfaceAddress} eq Ocean::system::NetworkInterfaceAddress()) {
								
								# print
								print "\t[recquirements] frontend : ".$frontend_ref->{Alias}." ; OK. scale !\n";
						
								# OK ! finally found it
								last FRONTEND_SCALING_RECQUIREMENTS_TEST;
								
							} # if()
							
						} # if() 
						
					} # for()
					
				} # if() 
			
			} # for()
			
			# print
			print "\t[recquirements] frontend : ".$frontend_ref->{Alias}." ; FAIL. skip !\n";
								
			# if this point is reached, then scaling recquirements have not met so... neeeext :)
			next FRONTEND;
			
		} # FRONTEND_SCALING_RECQUIREMENTS_TEST
	
		for my $alu_ref( @{ $Ocean::var::g__Labsim_simulation_properties{ALU} } ) {
		
			next if not $alu_ref->{Alias} eq $frontend_ref->{Alias};
			
			switch($alu_ref->{Lang}) {
				
				# C
				case ($Ocean::var::g__Labsim_language_UUID[0]) { 
					
				}
				
				# C++               
				case ($Ocean::var::g__Labsim_language_UUID[1]) { 
								
					# copy !
										
					Ocean::system::CopyFile($frontend_ref->{CXX}{Header}{Temporary},$frontend_ref->{CXX}{Header}{Destination});
					Ocean::system::CopyFile($frontend_ref->{CXX}{Source}{Temporary},$frontend_ref->{CXX}{Source}{Destination});
						
					# check !
						
					Ocean::system::CheckFile($frontend_ref->{CXX}{Header}{Destination});
					Ocean::system::CheckFile($frontend_ref->{CXX}{Source}{Destination});
						
				}
				
				# C#  
				case ($Ocean::var::g__Labsim_language_UUID[2]) { 
					
				}
				
				# Objective C
				case ($Ocean::var::g__Labsim_language_UUID[3]) { 
					
				}
				
				# Java 
				case ($Ocean::var::g__Labsim_language_UUID[4]) { 
					
				}   
				                                    
				# Android Java 
				case ($Ocean::var::g__Labsim_language_UUID[5]) { 
					
				}
				
				# Python 
				case ($Ocean::var::g__Labsim_language_UUID[6]) { 
					
				}
				
				# Go 
				case ($Ocean::var::g__Labsim_language_UUID[7]) { 
					
				}
				
				# NodeJS
				case ($Ocean::var::g__Labsim_language_UUID[8]) { 
					
				}
				
				# PHP
				case ($Ocean::var::g__Labsim_language_UUID[9]) { 
					
				}
				
				# Ruby on Rails 
				case ($Ocean::var::g__Labsim_language_UUID[10]) { 
					
				}
				
				# Matlab/Simulink coder plugin integration
				case ($Ocean::var::g__Labsim_language_UUID[11]) { 
					
				}
				
			} # switch()
		
		} # for()
	
	} # for()
		
} # STUB_Frontend()

sub STUB_Backend {
	
} # STUB_Backend()

sub STUB {
	
	STUB_Frontend();
	STUB_Backend();
	
} # STUB()

# end module
1;
__END__
