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
package Ocean::procedure::staging;

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
    our @EXPORT_OK   = qw(PROTO CMAKE STUB);
    
}  

# OCEAN package
use lib qw(../../../module);
use Ocean::system; 
use Ocean::var;
use Ocean::default;

# useful package
use IPC::System::Simple;
use XML::SimpleObject::LibXML;
use Switch;

# ------------------------------------
# OCEAN Staging package
# ------------------------------------
#
# Ce fichier contient l'ensemble des routines de configuration des fichiers de sorties en fonction des input du parsing
#
# author : 	Nawfel Kinani
# creation: 23/02/15
# group : 	Onera DCSD/PSEV LabSim
#

sub PROTO_Frontend {
		
	for my $frontend_ref( @{ $Ocean::var::g__Labsim_files_properties{Frontend} } ) {
		
		# ===================== #
		# Proto properties
		# ===================== #
		my $proto_file			= $frontend_ref->{Proto}{Temporary};
		# ===================== #
		
		# print user info
		print "\t==> Deploying file: $proto_file\n";
		
		print "\t[Frontend] ".$frontend_ref->{Alias}."\n";
				
		my ( @input_directives_array, @output_directives_array ) = ();
		for my $alu_ref ( @{ $Ocean::var::g__Labsim_simulation_properties{ALU} } ) {
			
			# skip if not equal
			next if not $alu_ref->{Alias} eq $frontend_ref->{Alias};
			
			# accumulate
			for my $slot_ref ( @{ $alu_ref->{Slot}{Input} } ) {
			
				push @input_directives_array, $Ocean::var::g__Thetys_dataset_UUID_hash{ $slot_ref->{Type} }." ".$slot_ref->{Alias}." = ".$slot_ref->{UUID}.";";
				
			} # for()
			
			for my $slot_ref ( @{ $alu_ref->{Slot}{Output} } ) {
			
				push @input_directives_array, $Ocean::var::g__Thetys_dataset_UUID_hash{ $slot_ref->{Type} }." ".$slot_ref->{Alias}." = ".$slot_ref->{UUID}.";";
				
			} # for()
			
		} # for()		
		
		# secondary treatment	
	
		Ocean::system::FindAndReplaceToken(
			$proto_file, 
			"\\[OCEAN_GENERATOR_PROTO_INPUT_DIRECTIVES\\]", 
			@input_directives_array ? join("\n\t", @input_directives_array) : "// no input !"
		);	
	
		Ocean::system::FindAndReplaceToken(
			$proto_file, 
			"\\[OCEAN_GENERATOR_PROTO_OUTPUT_DIRECTIVES\\]", 
			@output_directives_array ? join("\n\t", @output_directives_array) : "// no output !"
		);	
	
	} # for()
		
} # PROTO_Frontend()

sub PROTO_Backend {
		
	for my $backend_ref( @{ $Ocean::var::g__Labsim_files_properties{Backend} } ) {
		
		# ===================== #
		# Proto properties
		# ===================== #
		my $proto_file			= $backend_ref->{Proto}{Temporary};
		# ===================== #
		
		# print user info
		print "\t==> Deploying file: $proto_file\n";
		
		print "\t[Backend] ".$backend_ref->{Alias}."\n";
				
		my ( @input_directives_array, @output_directives_array ) = ();
		for my $alu_ref ( @{ $Ocean::var::g__Labsim_simulation_properties{ALU} } ) {
			
			# skip if not equal
			next if not $alu_ref->{Alias} eq $backend_ref->{Alias};
			
			# accumulate
			for my $slot_ref ( @{ $alu_ref->{Slot}{Input} } ) {
			
				push @input_directives_array, $Ocean::var::g__Thetys_dataset_UUID_hash{ $slot_ref->{Type} }." ".$slot_ref->{Alias}." = ".$slot_ref->{UUID}.";";
				
			} # for()
			
			for my $slot_ref ( @{ $alu_ref->{Slot}{Output} } ) {
			
				push @output_directives_array, $Ocean::var::g__Thetys_dataset_UUID_hash{ $slot_ref->{Type} }." ".$slot_ref->{Alias}." = ".$slot_ref->{UUID}.";";
				
			} # for()
			
		} # for()		
		
		# secondary treatment
	
		Ocean::system::FindAndReplaceToken(
			$proto_file, 
			"\\[OCEAN_GENERATOR_PROTO_INPUT_DIRECTIVES\\]", 
			@input_directives_array ? join("\n\t", @input_directives_array) : "// no input !"
		);	
	
		Ocean::system::FindAndReplaceToken(
			$proto_file, 
			"\\[OCEAN_GENERATOR_PROTO_OUTPUT_DIRECTIVES\\]", 
			@output_directives_array ? join("\n\t", @output_directives_array) : "// no output !"
		);	
	
	} # for()
		
} # PROTO_Backend()

sub PROTO {
	
	PROTO_Frontend();
	PROTO_Backend();
	
} # PROTO()

sub CMAKE_Frontend {
		
	for my $frontend_ref( @{ $Ocean::var::g__Labsim_files_properties{Frontend} } ) {
		
		# ===================== #
		# CMake properties
		# ===================== #
		my $cmake_file			= $frontend_ref->{CMake}{Temporary};
		# ===================== #
		
		# print user info
		print "\t==> Deploying file: $cmake_file\n";
		
		print "\t[Frontend] ".$frontend_ref->{Alias}."\n";
		
		my $lang = "";
		for my $alu_ref ( @{ $Ocean::var::g__Labsim_simulation_properties{ALU} } ) {
			
			# skip if not equal
			next if not $alu_ref->{Alias} eq $frontend_ref->{Alias};
			
			$lang = $alu_ref->{Lang};
		
		} # for()
		
		# secondary treatment
	
		Ocean::system::FindAndReplaceToken(
			$cmake_file, 
			"\\[OCEAN_GENERATOR_MODEL_NAME_DIRECTVES\\]", 
			$frontend_ref->{Alias}
		);	
		
		Ocean::system::FindAndReplaceToken(
			$cmake_file, 
			"\\[OCEAN_GENERATOR_MODEL_LANG_DIRECTVES\\]", 
			uc($lang)
		);
			
		Ocean::system::FindAndReplaceToken(
			$cmake_file, 
			"\\[OCEAN_GENERATOR_MODEL_INCLUDE_DIR_DIRECTVES\\]", 
			$Ocean::var::g__custom_project_dir."/labsim/colosses/".$frontend_ref->{Alias}
		);
		
		Ocean::system::FindAndReplaceToken(
			$cmake_file, 
			"\\[OCEAN_GENERATOR_MODEL_COMPILATION_FLAGS_DIRECTVES\\]", 
			""
		);	
		
		Ocean::system::FindAndReplaceToken(
			$cmake_file, 
			"\\[OCEAN_GENERATOR_MODEL_LINKED_LIBRARIES_DIRECTVES\\]", 
			""
		);
		
		Ocean::system::FindAndReplaceToken(
			$cmake_file, 
			"\\[OCEAN_GENERATOR_MODEL_LINKED_LIBRARY_DIR_DIRECTVES\\]", 
			""
		);
		
	} # for()
	
} # CMAKE_Frontend()

sub CMAKE_Backend {
		
	for my $backend_ref( @{ $Ocean::var::g__Labsim_files_properties{Backend} } ) {
		
		# ===================== #
		# CMake properties
		# ===================== #
		my $cmake_file			= $backend_ref->{CMake}{Temporary};
		# ===================== #
		
		# print user info
		print "\t==> Deploying file: $cmake_file\n";
		
		print "\t[Backend] ".$backend_ref->{Alias}."\n";
		
		my $lang = "";
		for my $alu_ref ( @{ $Ocean::var::g__Labsim_simulation_properties{ALU} } ) {
			
			# skip if not equal
			next if not $alu_ref->{Alias} eq $backend_ref->{Alias};
			
			$lang = $alu_ref->{Lang};
			
		} # for()
		
		# secondary treatment
	
		Ocean::system::FindAndReplaceToken(
			$cmake_file, 
			"\\[OCEAN_GENERATOR_MODEL_NAME_DIRECTVES\\]", 
			$backend_ref->{Alias}
		);	
		
		Ocean::system::FindAndReplaceToken(
			$cmake_file, 
			"\\[OCEAN_GENERATOR_MODEL_LANG_DIRECTVES\\]", 
			uc($lang)
		);
			
		Ocean::system::FindAndReplaceToken(
			$cmake_file, 
			"\\[OCEAN_GENERATOR_MODEL_INCLUDE_DIR_DIRECTVES\\]", 
			$Ocean::var::g__custom_project_dir."/labsim/colosses/".$backend_ref->{Alias}
		);
		
		Ocean::system::FindAndReplaceToken(
			$cmake_file, 
			"\\[OCEAN_GENERATOR_MODEL_COMPILATION_FLAGS_DIRECTVES\\]", 
			""
		);	
		
		Ocean::system::FindAndReplaceToken(
			$cmake_file, 
			"\\[OCEAN_GENERATOR_MODEL_LINKED_LIBRARIES_DIRECTVES\\]", 
			""
		);
		
		Ocean::system::FindAndReplaceToken(
			$cmake_file, 
			"\\[OCEAN_GENERATOR_MODEL_LINKED_LIBRARY_DIR_DIRECTVES\\]", 
			""
		);
		
	} # for()
	
} # CMAKE_Backend()

sub CMAKE {
 
	CMAKE_Frontend();
	CMAKE_Backend();
 
} # CMAKE()

sub STUB_Frontend {
	
	for my $frontend_ref( @{ $Ocean::var::g__Labsim_files_properties{Frontend} } ) {
		
		for my $alu_ref( @{ $Ocean::var::g__Labsim_simulation_properties{ALU} } ) {
		
			next if not $alu_ref->{Alias} eq $frontend_ref->{Alias};
			
			switch($alu_ref->{Lang}) {
			
				# C
				case ($Ocean::var::g__Labsim_language_UUID[0]) { 
					
				}
				
				# C++               
				case ($Ocean::var::g__Labsim_language_UUID[1]) { 
						
					# ===================== #
					# STUB properties
					# ===================== #
					my $cxx_header_file	= $frontend_ref->{CXX}{Header}{Temporary};
					my $cxx_source_file	= $frontend_ref->{CXX}{Source}{Temporary};
					# ===================== #
	
					# print user info
					print "\t==> Deploying file: $cxx_header_file\n";
					
					print "\t[Frontend] ".$frontend_ref->{Alias}."\n";
					
					# secondary treatment 
					
					Ocean::system::FindAndReplaceToken(
						$cxx_header_file, 
						"\\[OCEAN_GENERATOR_MODEL_ALIAS_DIRECTIVES\\]",
						 $frontend_ref->{Alias}
					 );	
					Ocean::system::FindAndReplaceToken(
						$cxx_header_file,
						 "\\[OCEAN_GENERATOR_MODEL_UPPERCASE_ALIAS_DIRECTIVES\\]", 
						 uc($frontend_ref->{Alias})
					 );
					
					# print user info
					print "\t==> Deploying file: $cxx_source_file\n";
					
					print "\t[Frontend] ".$frontend_ref->{Alias}."\n";
						
					# secondary treatment 
					
					Ocean::system::FindAndReplaceToken(
						$cxx_source_file, 
						"\\[OCEAN_GENERATOR_MODEL_ALIAS_DIRECTIVES\\]", 
						$frontend_ref->{Alias}
					);
					
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
	
	# noting for the moment
	
} # STUB_Backend()

sub STUB {
	
	STUB_Frontend();
	STUB_Backend();
	
} # STUB()

# end module
1;
__END__
