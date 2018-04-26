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
package Ocean::function;

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
    	RemoveTemporaryTree
    	AddFrontendFilesProperties
    	AddBackendFilesProperties
    	ValidateOrigin
    	ValidateFrontendOrigin
    	ValidateBackendOrigin
		MakeFrontendTemporaryTree
		MakeBackendTemporaryTree
		PrepareFrontendDestination
		PrepareBackendDestination
    	ProcessCommandLineOptions
    	BuildHashes
    	DumpVar
    );
    
}

# OCEAN package
use lib qw(../../module);
use Ocean::default;
use Ocean::system;
use Ocean::var;
use Ocean::help;

# useful package
use Data::Dumper;

# ==================================================================================================================
# 												General subroutines 
# ==================================================================================================================

###
# Function de remove des fichers temporaire
sub RemoveTemporaryTree {
	
	# check options
	if(!$Ocean::var::g__debug_flag) {
		
		# On efface les fichiers tmp/* si present + script tmp.pl restant
		Ocean::system::RemoveDirectory($Ocean::default::TMP_PATH);
		Ocean::system::RemoveFile($FindBin::Bin."/tmp.pl");
	
	}
	
} # RemoveTemporaryTree()

sub AddFrontendFilesProperties {
	
	my $model_alias = shift;
	
	push @{ $Ocean::var::g__Labsim_files_properties{Frontend} }, {
		Alias => $model_alias,
		XML => {
			ALU	=> ""
		},
		Proto => { Origin => "", Temporary => "", Destination => "" },
		CMake => { Origin => "", Temporary => "", Destination => "" },
		CXX => {
			Header => { Origin => "", Temporary => "", Destination => "" },
			Source => { Origin => "", Temporary => "", Destination => "" }
		}
	};	
	
} # AddFrontendFilesProperties()

sub AddBackendFilesProperties {
	
	my $model_alias = shift;
	
	push @{ $Ocean::var::g__Labsim_files_properties{Backend} }, {
		Alias => $model_alias,
		XML => {
			ALU	=> ""
		},
		Proto => { Origin => "", Temporary => "", Destination => "" },
		CMake => { Origin => "", Temporary => "", Destination => "" },
		#CXX => {
		#	Header => { Origin => "", Temporary => "", Destination => "" },
		#	Source => { Origin => "", Temporary => "", Destination => "" }
		#}
	};
	
} # AddBackendFilesProperties()

###
# Fonction de test de l'existance des fichiers et repertoire demandé en paramètres
sub ValidateOrigin {
	
	# set & validate origin files
		
	$Ocean::var::g__Labsim_files_properties{XML}{SLU} = Ocean::system::CleanPath($Ocean::var::g__custom_experiment_dir."/SequentialLogicUnit.xml");
	Ocean::system::CheckFile($Ocean::var::g__Labsim_files_properties{XML}{SLU});
	
	$Ocean::var::g__Labsim_files_properties{XML}{HCU} = Ocean::system::CleanPath($Ocean::var::g__custom_experiment_dir."/HardwireControlUnit.xml");
	Ocean::system::CheckFile($Ocean::var::g__Labsim_files_properties{XML}{HCU});
	
} #() ValidateOrigin

###
# Fonction de test de l'existance des fichiers et repertoire demandé en paramètres
sub ValidateFrontendOrigin {
	
	my $frontend_alias = shift;
	
	# set & validate origin files
	
	for my $frontend_ref( @{ $Ocean::var::g__Labsim_files_properties{Frontend} } ) {
		
		# discard
		next if(not $frontend_ref->{Alias} eq $frontend_alias);
	
		# set & validate origin files
				
		$frontend_ref->{XML}{ALU} = Ocean::system::CleanPath($Ocean::var::g__custom_experiment_dir."/model/".$frontend_alias."/ArithmeticLogicUnit.xml");
		Ocean::system::CheckFile($frontend_ref->{XML}{ALU});
		
		$frontend_ref->{Proto}{Origin} = Ocean::system::CleanPath($Ocean::default::PROTO_TEMPLATE_PATH."/Ocean-template.proto");
		Ocean::system::CheckFile($frontend_ref->{Proto}{Origin});
		
		$frontend_ref->{CMake}{Origin} = Ocean::system::CleanPath($Ocean::default::CMAKE_TEMPLATE_PATH."/Ocean-template.cmake");
		Ocean::system::CheckFile($frontend_ref->{CMake}{Origin});

		$frontend_ref->{CXX}{Header}{Origin} = Ocean::system::CleanPath($Ocean::default::FRONTEND_CXX_TEMPLATE_PATH."/Ocean-template.hpp");
		Ocean::system::CheckFile($frontend_ref->{CXX}{Header}{Origin});
		
		$frontend_ref->{CXX}{Source}{Origin} = Ocean::system::CleanPath($Ocean::default::FRONTEND_CXX_TEMPLATE_PATH."/Ocean-template.cpp");
		Ocean::system::CheckFile($frontend_ref->{CXX}{Source}{Origin});
		
	} # for()
	
} # ValidateFrontendOrigin()

###
# Fonction de test de l'existance des fichiers et repertoire demandé en paramètres
sub ValidateBackendOrigin {
	
	my $backend_alias = shift;
	
	# set & validate origin files
	
	for my $backend_ref( @{ $Ocean::var::g__Labsim_files_properties{Backend} } ) {
		
		# discard
		next if(not $backend_ref->{Alias} eq $backend_alias);
	
		# set & validate origin files
				
		$backend_ref->{XML}{ALU} = Ocean::system::CleanPath($Ocean::var::g__custom_experiment_dir."/model/".$backend_alias."/ArithmeticLogicUnit.xml");
		Ocean::system::CheckFile($backend_ref->{XML}{ALU});
		
		$backend_ref->{Proto}{Origin} = Ocean::system::CleanPath($Ocean::default::PROTO_TEMPLATE_PATH."/Ocean-template.proto");
		Ocean::system::CheckFile($backend_ref->{Proto}{Origin});
		
		$backend_ref->{CMake}{Origin} = Ocean::system::CleanPath($Ocean::default::CMAKE_TEMPLATE_PATH."/Ocean-template.cmake");
		Ocean::system::CheckFile($backend_ref->{CMake}{Origin});

		#$backend_ref->{CXX}{Header}{Origin} = Ocean::system::CleanPath($Ocean::default::FRONTEND_CXX_TEMPLATE_PATH."/Ocean-template.hpp");
		#Ocean::system::CheckFile($backend_ref->{CXX}{Header}{Origin});
		#
		#$backend_ref->{CXX}{Source}{Origin} = Ocean::system::CleanPath($Ocean::default::FRONTEND_CXX_TEMPLATE_PATH."/Ocean-template.cpp");
		#Ocean::system::CheckFile($backend_ref->{CXX}{Source}{Origin});
		
	} # for()
	
} # ValidateBackendOrigin()

sub MakeFrontendTemporaryTree {
	
	my $frontend_alias = shift;
	
	# make temporary folder 
	
	Ocean::system::MakeDirectory($Ocean::default::TMP_PATH."/frontend/".$frontend_alias."/cxx");
	Ocean::system::CheckDirectory($Ocean::default::TMP_PATH."/frontend/".$frontend_alias."/cxx");
	
	Ocean::system::MakeDirectory($Ocean::default::TMP_PATH."/frontend/".$frontend_alias."/share/cmake");
	Ocean::system::CheckDirectory($Ocean::default::TMP_PATH."/frontend/".$frontend_alias."/share/cmake");
	
	Ocean::system::MakeDirectory($Ocean::default::TMP_PATH."/frontend/".$frontend_alias."/share/proto");
	Ocean::system::CheckDirectory($Ocean::default::TMP_PATH."/frontend/".$frontend_alias."/share/proto");
	
	# make temporary file

	for my $frontend_ref( @{ $Ocean::var::g__Labsim_files_properties{Frontend} } ) {
		
		# discard
		next if(not $frontend_ref->{Alias} eq $frontend_alias);
		
		$frontend_ref->{Proto}{Temporary} = Ocean::system::CleanPath($Ocean::default::TMP_PATH."/frontend/".$frontend_alias."/share/proto/Thetys.proto");
		Ocean::system::CopyFile($frontend_ref->{Proto}{Origin},$frontend_ref->{Proto}{Temporary});
		Ocean::system::CheckFile($frontend_ref->{Proto}{Temporary});
		
		$frontend_ref->{CMake}{Temporary} = Ocean::system::CleanPath($Ocean::default::TMP_PATH."/frontend/".$frontend_alias."/share/proto/model-config.cmake");
		Ocean::system::CopyFile($frontend_ref->{CMake}{Origin},$frontend_ref->{CMake}{Temporary});
		Ocean::system::CheckFile($frontend_ref->{CMake}{Temporary});
		
		$frontend_ref->{CXX}{Header}{Temporary} = Ocean::system::CleanPath($Ocean::default::TMP_PATH."/frontend/".$frontend_alias."/cxx/".$frontend_alias.".hpp");
		Ocean::system::CopyFile($frontend_ref->{CXX}{Header}{Origin},$frontend_ref->{CXX}{Header}{Temporary});
		Ocean::system::CheckFile($frontend_ref->{CXX}{Header}{Temporary});
		
		$frontend_ref->{CXX}{Source}{Temporary} = Ocean::system::CleanPath($Ocean::default::TMP_PATH."/frontend/".$frontend_alias."/cxx/".$frontend_alias.".cpp");
		Ocean::system::CopyFile($frontend_ref->{CXX}{Source}{Origin},$frontend_ref->{CXX}{Source}{Temporary});
		Ocean::system::CheckFile($frontend_ref->{CXX}{Source}{Temporary});
		
	} # for()

} # MakeFrontendTemporaryTree()

sub MakeBackendTemporaryTree {
	
	my $backend_alias = shift;
	
	# make temporary folder 
	
	#Ocean::system::MakeDirectory($Ocean::default::TMP_PATH."/backend/".$backend_alias."/cxx");
	#Ocean::system::CheckDirectory($Ocean::default::TMP_PATH."/backend/".$backend_alias."/cxx");
	
	Ocean::system::MakeDirectory($Ocean::default::TMP_PATH."/backend/".$backend_alias."/share/cmake");
	Ocean::system::CheckDirectory($Ocean::default::TMP_PATH."/backend/".$backend_alias."/share/cmake");
	
	Ocean::system::MakeDirectory($Ocean::default::TMP_PATH."/backend/".$backend_alias."/share/proto");
	Ocean::system::CheckDirectory($Ocean::default::TMP_PATH."/backend/".$backend_alias."/share/proto");
	
	# make temporary file

	for my $backend_ref( @{ $Ocean::var::g__Labsim_files_properties{Backend} } ) {
		
		# discard
		next if(not $backend_ref->{Alias} eq $backend_alias);
		
		$backend_ref->{Proto}{Temporary} = Ocean::system::CleanPath($Ocean::default::TMP_PATH."/backend/".$backend_alias."/share/proto/Thetys.proto");
		Ocean::system::CopyFile($backend_ref->{Proto}{Origin},$backend_ref->{Proto}{Temporary});
		Ocean::system::CheckFile($backend_ref->{Proto}{Temporary});
		
		$backend_ref->{CMake}{Temporary} = Ocean::system::CleanPath($Ocean::default::TMP_PATH."/backend/".$backend_alias."/share/proto/model-config.cmake");
		Ocean::system::CopyFile($backend_ref->{CMake}{Origin},$backend_ref->{CMake}{Temporary});
		Ocean::system::CheckFile($backend_ref->{CMake}{Temporary});
		
		#$backend_ref->{CXX}{Header}{Temporary} = Ocean::system::CleanPath($Ocean::default::TMP_PATH."/backend/".$backend_alias."/cxx/".$backend_alias.".hpp");
		#Ocean::system::CopyFile($backend_ref->{CXX}{Header}{Origin},$backend_ref->{CXX}{Header}{Temporary});
		#Ocean::system::CheckFile($backend_ref->{CXX}{Header}{Temporary});
		#
		#$backend_ref->{CXX}{Source}{Temporary} = Ocean::system::CleanPath($Ocean::default::TMP_PATH."/backend/".$backend_alias."/cxx/".$backend_alias.".cpp");
		#Ocean::system::CopyFile($backend_ref->{CXX}{Source}{Origin},$backend_ref->{CXX}{Source}{Temporary});
		#Ocean::system::CheckFile($backend_ref->{CXX}{Source}{Temporary});
		
	} # for()

} # MakeBackendTemporaryTree()

sub PrepareFrontendDestination {
	
	my $frontend_alias = shift;
	
	# set destination files

	for my $frontend_ref( @{ $Ocean::var::g__Labsim_files_properties{Frontend} } ) {
		
		# discard
		next if(not $frontend_ref->{Alias} eq $frontend_alias);
		
		$frontend_ref->{Proto}{Destination}
			= Ocean::system::CleanPath(
				$Ocean::var::g__custom_project_dir
					."/labsim/colosses/"
					.$frontend_alias
					."/share/proto/"
					.Ocean::system::Filename($frontend_ref->{Proto}{Temporary})
					.Ocean::system::Fileext($frontend_ref->{Proto}{Temporary})
			);
		
		$frontend_ref->{CMake}{Destination}
			= Ocean::system::CleanPath(
				$Ocean::var::g__custom_project_dir
					."/labsim/colosses/"
					.$frontend_alias
					."/share/cmake/"
					.Ocean::system::Filename($frontend_ref->{CMake}{Temporary})
					.Ocean::system::Fileext($frontend_ref->{CMake}{Temporary})
			);
		
		$frontend_ref->{CXX}{Header}{Destination}
			= Ocean::system::CleanPath(
				$Ocean::var::g__custom_project_dir
					."/labsim/colosses/"
					.$frontend_alias
					."/"
					.Ocean::system::Filename($frontend_ref->{CXX}{Header}{Temporary})
					.Ocean::system::Fileext($frontend_ref->{CXX}{Header}{Temporary})
			);
		
		$frontend_ref->{CXX}{Source}{Destination}
			= Ocean::system::CleanPath(
				$Ocean::var::g__custom_project_dir
					."/labsim/colosses/"
					.$frontend_alias
					."/"
					.Ocean::system::Filename($frontend_ref->{CXX}{Source}{Temporary})
					.Ocean::system::Fileext($frontend_ref->{CXX}{Source}{Temporary})
			);
		
	} # for()

} # PrepareFrontendDestination()

sub PrepareBackendDestination {
	
	my $backend_alias = shift;
	
	# set destination files

	for my $backend_ref( @{ $Ocean::var::g__Labsim_files_properties{Backend} } ) {
		
		# discard
		next if(not $backend_ref->{Alias} eq $backend_alias);
		
		$backend_ref->{Proto}{Destination}
			= Ocean::system::CleanPath(
				$Ocean::var::g__custom_project_dir
					."/labsim/colosses/"
					.$backend_alias
					."/share/proto/"
					.Ocean::system::Filename($backend_ref->{Proto}{Temporary})
					.Ocean::system::Fileext($backend_ref->{Proto}{Temporary})
			);
		
		$backend_ref->{CMake}{Destination}
			= Ocean::system::CleanPath(
				$Ocean::var::g__custom_project_dir
					."/labsim/colosses/"
					.$backend_alias
					."/share/cmake/"
					.Ocean::system::Filename($backend_ref->{CMake}{Temporary})
					.Ocean::system::Fileext($backend_ref->{CMake}{Temporary})
			);
		
		#$backend_ref->{CXX}{Header}{Temporary}
		#	= Ocean::system::CleanPath(
		#		$Ocean::var::g__custom_project_dir
		#			."/labsim/colosses/"
		#			.$backend_alias
		#			.Ocean::system::Filename($backend_ref->{CXX}{Header}{Temporary})
		#			.Ocean::system::Fileext($backend_ref->{CXX}{Header}{Temporary})
		#	);
		#
		#$backend_ref->{CXX}{Source}{Temporary}
		#	= Ocean::system::CleanPath(
		#		$Ocean::var::g__custom_project_dir
		#			."/labsim/colosses/"
		#			.$backend_alias
		#			.Ocean::system::Filename($backend_ref->{CXX}{Source}{Temporary})
		#			.Ocean::system::Fileext($backend_ref->{CXX}{Source}{Temporary})
		#	);
		
	} # for()

} # PrepareBackendDestination()

###
# Fonction de Processing des arguments
sub ProcessCommandLineOptions {
	
	# On parse nos arguments
	Ocean::system::ParseCommandLineOptions();
	
} # ProcessCommandLineOptions()

sub BuildHashes() {

	# language
	$Ocean::var::g__Labsim_language_UUID_hash{$_} = ($Ocean::var::g__Labsim_language_UUID[0]) for @Ocean::var::g__Labsim_language_c_UUID;
	$Ocean::var::g__Labsim_language_UUID_hash{$_} = ($Ocean::var::g__Labsim_language_UUID[1]) for @Ocean::var::g__Labsim_language_cxx_UUID;
	$Ocean::var::g__Labsim_language_UUID_hash{$_} = ($Ocean::var::g__Labsim_language_UUID[2]) for @Ocean::var::g__Labsim_language_csharp_UUID;
	$Ocean::var::g__Labsim_language_UUID_hash{$_} = ($Ocean::var::g__Labsim_language_UUID[3]) for @Ocean::var::g__Labsim_language_objc_UUID;
	$Ocean::var::g__Labsim_language_UUID_hash{$_} = ($Ocean::var::g__Labsim_language_UUID[4]) for @Ocean::var::g__Labsim_language_java_UUID;
	$Ocean::var::g__Labsim_language_UUID_hash{$_} = ($Ocean::var::g__Labsim_language_UUID[5]) for @Ocean::var::g__Labsim_language_java_android_UUID;
	$Ocean::var::g__Labsim_language_UUID_hash{$_} = ($Ocean::var::g__Labsim_language_UUID[6]) for @Ocean::var::g__Labsim_language_python_UUID;
	$Ocean::var::g__Labsim_language_UUID_hash{$_} = ($Ocean::var::g__Labsim_language_UUID[7]) for @Ocean::var::g__Labsim_language_go_UUID;
	$Ocean::var::g__Labsim_language_UUID_hash{$_} = ($Ocean::var::g__Labsim_language_UUID[8]) for @Ocean::var::g__Labsim_language_nodejs_UUID;
	$Ocean::var::g__Labsim_language_UUID_hash{$_} = ($Ocean::var::g__Labsim_language_UUID[9]) for @Ocean::var::g__Labsim_language_php_UUID;
	$Ocean::var::g__Labsim_language_UUID_hash{$_} = ($Ocean::var::g__Labsim_language_UUID[10]) for @Ocean::var::g__Labsim_language_ruby_UUID;
	$Ocean::var::g__Labsim_language_UUID_hash{$_} = ($Ocean::var::g__Labsim_language_UUID[11]) for @Ocean::var::g__Labsim_language_simulink_UUID;

	# dataset
	$Ocean::var::g__Labsim_dataset_UUID_hash{$_} = ($Ocean::var::g__Labsim_dataset_UUID[0]) for @Ocean::var::g__Labsim_dataset_boolean_UUID;
	$Ocean::var::g__Labsim_dataset_UUID_hash{$_} = ($Ocean::var::g__Labsim_dataset_UUID[1]) for @Ocean::var::g__Labsim_dataset_char_UUID;
	$Ocean::var::g__Labsim_dataset_UUID_hash{$_} = ($Ocean::var::g__Labsim_dataset_UUID[2]) for @Ocean::var::g__Labsim_dataset_octet_UUID;
	$Ocean::var::g__Labsim_dataset_UUID_hash{$_} = ($Ocean::var::g__Labsim_dataset_UUID[3]) for @Ocean::var::g__Labsim_dataset_short_UUID;
	$Ocean::var::g__Labsim_dataset_UUID_hash{$_} = ($Ocean::var::g__Labsim_dataset_UUID[4]) for @Ocean::var::g__Labsim_dataset_unsigned_short_UUID;
	$Ocean::var::g__Labsim_dataset_UUID_hash{$_} = ($Ocean::var::g__Labsim_dataset_UUID[5]) for @Ocean::var::g__Labsim_dataset_long_UUID;
	$Ocean::var::g__Labsim_dataset_UUID_hash{$_} = ($Ocean::var::g__Labsim_dataset_UUID[6]) for @Ocean::var::g__Labsim_dataset_unsigned_long_UUID;
	$Ocean::var::g__Labsim_dataset_UUID_hash{$_} = ($Ocean::var::g__Labsim_dataset_UUID[7]) for @Ocean::var::g__Labsim_dataset_long_long_UUID;
	$Ocean::var::g__Labsim_dataset_UUID_hash{$_} = ($Ocean::var::g__Labsim_dataset_UUID[8]) for @Ocean::var::g__Labsim_dataset_unsigned_long_long_UUID;
	$Ocean::var::g__Labsim_dataset_UUID_hash{$_} = ($Ocean::var::g__Labsim_dataset_UUID[9]) for @Ocean::var::g__Labsim_dataset_float_UUID;
	$Ocean::var::g__Labsim_dataset_UUID_hash{$_} = ($Ocean::var::g__Labsim_dataset_UUID[10]) for @Ocean::var::g__Labsim_dataset_double_UUID;
	$Ocean::var::g__Labsim_dataset_UUID_hash{$_} = ($Ocean::var::g__Labsim_dataset_UUID[11]) for @Ocean::var::g__Labsim_dataset_string_UUID;
	$Ocean::var::g__Labsim_dataset_UUID_hash{$_} = ($Ocean::var::g__Labsim_dataset_UUID[12]) for @Ocean::var::g__Labsim_dataset_vec2f_UUID;
	$Ocean::var::g__Labsim_dataset_UUID_hash{$_} = ($Ocean::var::g__Labsim_dataset_UUID[13]) for @Ocean::var::g__Labsim_dataset_vec3f_UUID;
	$Ocean::var::g__Labsim_dataset_UUID_hash{$_} = ($Ocean::var::g__Labsim_dataset_UUID[14]) for @Ocean::var::g__Labsim_dataset_vec4f_UUID;
	$Ocean::var::g__Labsim_dataset_UUID_hash{$_} = ($Ocean::var::g__Labsim_dataset_UUID[15]) for @Ocean::var::g__Labsim_dataset_matrixf_UUID;
	$Ocean::var::g__Labsim_dataset_UUID_hash{$_} = ($Ocean::var::g__Labsim_dataset_UUID[16]) for @Ocean::var::g__Labsim_dataset_vec2d_UUID;
	$Ocean::var::g__Labsim_dataset_UUID_hash{$_} = ($Ocean::var::g__Labsim_dataset_UUID[17]) for @Ocean::var::g__Labsim_dataset_vec3d_UUID;
	$Ocean::var::g__Labsim_dataset_UUID_hash{$_} = ($Ocean::var::g__Labsim_dataset_UUID[18]) for @Ocean::var::g__Labsim_dataset_vec4d_UUID;
	$Ocean::var::g__Labsim_dataset_UUID_hash{$_} = ($Ocean::var::g__Labsim_dataset_UUID[19]) for @Ocean::var::g__Labsim_dataset_matrixd_UUID;
	
	# thetys dataset
	$Ocean::var::g__Thetys_dataset_UUID_hash{ $Ocean::var::g__Labsim_dataset_UUID[0]  } = $Ocean::var::g__Thetys_dataset_UUID[0];
	$Ocean::var::g__Thetys_dataset_UUID_hash{ $Ocean::var::g__Labsim_dataset_UUID[1]  } = $Ocean::var::g__Thetys_dataset_UUID[1];
	$Ocean::var::g__Thetys_dataset_UUID_hash{ $Ocean::var::g__Labsim_dataset_UUID[2]  } = $Ocean::var::g__Thetys_dataset_UUID[2];
	$Ocean::var::g__Thetys_dataset_UUID_hash{ $Ocean::var::g__Labsim_dataset_UUID[3]  } = $Ocean::var::g__Thetys_dataset_UUID[3];
	$Ocean::var::g__Thetys_dataset_UUID_hash{ $Ocean::var::g__Labsim_dataset_UUID[4]  } = $Ocean::var::g__Thetys_dataset_UUID[4];
	$Ocean::var::g__Thetys_dataset_UUID_hash{ $Ocean::var::g__Labsim_dataset_UUID[5]  } = $Ocean::var::g__Thetys_dataset_UUID[5];
	$Ocean::var::g__Thetys_dataset_UUID_hash{ $Ocean::var::g__Labsim_dataset_UUID[6]  } = $Ocean::var::g__Thetys_dataset_UUID[6];
	$Ocean::var::g__Thetys_dataset_UUID_hash{ $Ocean::var::g__Labsim_dataset_UUID[7]  } = $Ocean::var::g__Thetys_dataset_UUID[7];
	$Ocean::var::g__Thetys_dataset_UUID_hash{ $Ocean::var::g__Labsim_dataset_UUID[8]  } = $Ocean::var::g__Thetys_dataset_UUID[8];
	$Ocean::var::g__Thetys_dataset_UUID_hash{ $Ocean::var::g__Labsim_dataset_UUID[9]  } = $Ocean::var::g__Thetys_dataset_UUID[9];
	$Ocean::var::g__Thetys_dataset_UUID_hash{ $Ocean::var::g__Labsim_dataset_UUID[10] } = $Ocean::var::g__Thetys_dataset_UUID[10];
	$Ocean::var::g__Thetys_dataset_UUID_hash{ $Ocean::var::g__Labsim_dataset_UUID[11] } = $Ocean::var::g__Thetys_dataset_UUID[11];
	$Ocean::var::g__Thetys_dataset_UUID_hash{ $Ocean::var::g__Labsim_dataset_UUID[12] } = $Ocean::var::g__Thetys_dataset_UUID[12];
	$Ocean::var::g__Thetys_dataset_UUID_hash{ $Ocean::var::g__Labsim_dataset_UUID[13] } = $Ocean::var::g__Thetys_dataset_UUID[13];
	$Ocean::var::g__Thetys_dataset_UUID_hash{ $Ocean::var::g__Labsim_dataset_UUID[14] } = $Ocean::var::g__Thetys_dataset_UUID[14];
	$Ocean::var::g__Thetys_dataset_UUID_hash{ $Ocean::var::g__Labsim_dataset_UUID[15] } = $Ocean::var::g__Thetys_dataset_UUID[15];
	$Ocean::var::g__Thetys_dataset_UUID_hash{ $Ocean::var::g__Labsim_dataset_UUID[16] } = $Ocean::var::g__Thetys_dataset_UUID[16];
	$Ocean::var::g__Thetys_dataset_UUID_hash{ $Ocean::var::g__Labsim_dataset_UUID[17] } = $Ocean::var::g__Thetys_dataset_UUID[17];
	$Ocean::var::g__Thetys_dataset_UUID_hash{ $Ocean::var::g__Labsim_dataset_UUID[18] } = $Ocean::var::g__Thetys_dataset_UUID[18];
	$Ocean::var::g__Thetys_dataset_UUID_hash{ $Ocean::var::g__Labsim_dataset_UUID[19] } = $Ocean::var::g__Thetys_dataset_UUID[19];

	# unitset
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[0]) for @Ocean::var::g__Labsim_unitset_undefined_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[1]) for @Ocean::var::g__Labsim_unitset_meter_per_square_second_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[2]) for @Ocean::var::g__Labsim_unitset_foot_per_square_second_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[3]) for @Ocean::var::g__Labsim_unitset_radian_per_square_second_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[4]) for @Ocean::var::g__Labsim_unitset_degree_per_square_second_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[5]) for @Ocean::var::g__Labsim_unitset_radian_per_second_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[6]) for @Ocean::var::g__Labsim_unitset_degree_per_second_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[7]) for @Ocean::var::g__Labsim_unitset_revolution_per_minute_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[8]) for @Ocean::var::g__Labsim_unitset_square_meter_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[9]) for @Ocean::var::g__Labsim_unitset_square_kilometer_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[10]) for @Ocean::var::g__Labsim_unitset_square_centimeter_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[11]) for @Ocean::var::g__Labsim_unitset_square_millimeter_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[12]) for @Ocean::var::g__Labsim_unitset_square_foot_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[13]) for @Ocean::var::g__Labsim_unitset_square_inch_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[14]) for @Ocean::var::g__Labsim_unitset_square_mile_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[15]) for @Ocean::var::g__Labsim_unitset_square_yard_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[16]) for @Ocean::var::g__Labsim_unitset_joule_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[17]) for @Ocean::var::g__Labsim_unitset_kilojoule_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[18]) for @Ocean::var::g__Labsim_unitset_calorie_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[19]) for @Ocean::var::g__Labsim_unitset_kilowatt_per_hour_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[20]) for @Ocean::var::g__Labsim_unitset_watt_per_hour_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[21]) for @Ocean::var::g__Labsim_unitset_newton_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[22]) for @Ocean::var::g__Labsim_unitset_kilonewton_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[23]) for @Ocean::var::g__Labsim_unitset_dekanewton_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[24]) for @Ocean::var::g__Labsim_unitset_pound_force_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[25]) for @Ocean::var::g__Labsim_unitset_meter_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[26]) for @Ocean::var::g__Labsim_unitset_kilometer_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[27]) for @Ocean::var::g__Labsim_unitset_centimeter_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[28]) for @Ocean::var::g__Labsim_unitset_millimeter_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[29]) for @Ocean::var::g__Labsim_unitset_foot_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[30]) for @Ocean::var::g__Labsim_unitset_inch_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[31]) for @Ocean::var::g__Labsim_unitset_mile_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[32]) for @Ocean::var::g__Labsim_unitset_yard_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[33]) for @Ocean::var::g__Labsim_unitset_kilogram_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[34]) for @Ocean::var::g__Labsim_unitset_metric_ton_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[35]) for @Ocean::var::g__Labsim_unitset_hectogram_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[36]) for @Ocean::var::g__Labsim_unitset_dekagram_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[37]) for @Ocean::var::g__Labsim_unitset_gram_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[38]) for @Ocean::var::g__Labsim_unitset_centigram_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[39]) for @Ocean::var::g__Labsim_unitset_once_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[40]) for @Ocean::var::g__Labsim_unitset_pound_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[41]) for @Ocean::var::g__Labsim_unitset_radian_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[42]) for @Ocean::var::g__Labsim_unitset_degree_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[43]) for @Ocean::var::g__Labsim_unitset_watt_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[44]) for @Ocean::var::g__Labsim_unitset_kilowatt_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[45]) for @Ocean::var::g__Labsim_unitset_horsepower_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[46]) for @Ocean::var::g__Labsim_unitset_pascal_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[47]) for @Ocean::var::g__Labsim_unitset_kilopascal_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[48]) for @Ocean::var::g__Labsim_unitset_hectopascal_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[49]) for @Ocean::var::g__Labsim_unitset_bar_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[50]) for @Ocean::var::g__Labsim_unitset_standard_atmosphere_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[51]) for @Ocean::var::g__Labsim_unitset_kelvin_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[52]) for @Ocean::var::g__Labsim_unitset_celsuis_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[53]) for @Ocean::var::g__Labsim_unitset_fahrenheit_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[54]) for @Ocean::var::g__Labsim_unitset_second_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[55]) for @Ocean::var::g__Labsim_unitset_minute_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[56]) for @Ocean::var::g__Labsim_unitset_hour_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[57]) for @Ocean::var::g__Labsim_unitset_day_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[58]) for @Ocean::var::g__Labsim_unitset_julian_year_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[59]) for @Ocean::var::g__Labsim_unitset_millisecond_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[60]) for @Ocean::var::g__Labsim_unitset_microsecond_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[61]) for @Ocean::var::g__Labsim_unitset_nanosecond_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[62]) for @Ocean::var::g__Labsim_unitset_newton_meter_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[63]) for @Ocean::var::g__Labsim_unitset_kilonewton_meter_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[64]) for @Ocean::var::g__Labsim_unitset_dekanewton_meter_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[65]) for @Ocean::var::g__Labsim_unitset_meter_per_second_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[66]) for @Ocean::var::g__Labsim_unitset_meter_per_minute_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[67]) for @Ocean::var::g__Labsim_unitset_kilometer_per_hour_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[68]) for @Ocean::var::g__Labsim_unitset_foot_per_minute_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[69]) for @Ocean::var::g__Labsim_unitset_mile_per_hour_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[70]) for @Ocean::var::g__Labsim_unitset_knot_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[71]) for @Ocean::var::g__Labsim_unitset_mach_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[72]) for @Ocean::var::g__Labsim_unitset_cubic_meter_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[73]) for @Ocean::var::g__Labsim_unitset_cubic_kilometer_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[74]) for @Ocean::var::g__Labsim_unitset_cubic_centimeter_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[75]) for @Ocean::var::g__Labsim_unitset_cubic_millimeter_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[76]) for @Ocean::var::g__Labsim_unitset_cubic_foot_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[77]) for @Ocean::var::g__Labsim_unitset_cubic_inch_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[78]) for @Ocean::var::g__Labsim_unitset_cubic_mile_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[79]) for @Ocean::var::g__Labsim_unitset_cubic_yard_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[80]) for @Ocean::var::g__Labsim_unitset_gallon_UUID;
	$Ocean::var::g__Labsim_unitset_UUID_hash{$_} = ($Ocean::var::g__Labsim_unitset_UUID[81]) for @Ocean::var::g__Labsim_unitset_liter_UUID;
	
} # BuildHashes()

sub DumpVar() {
	
	if($Ocean::var::g__dump_flag) {
		
		$Data::Dumper::Terse 	= 0;        # output names where feasible
		$Data::Dumper::Indent 	= 3;       	# pretty print with array indices
	    $Data::Dumper::Useqq 	= 1;        # print strings in double quotes
	   	$Data::Dumper::Pair 	= " : ";    # specify hash key/value separator
	   	$Data::Dumper::Purity 	= 1;       	# avoid cross-refs
	   	$Data::Dumper::Deepcopy = 1; 	 	# avoid cross-refs
	   	
	  	print "\n==[ Ocean::var::g__Labsim_files_properties ]==\n".Dumper(%Ocean::var::g__Labsim_files_properties);
	  	print "\n==[ Ocean::var::g__Labsim_simulation_properties ]==\n".Dumper(%Ocean::var::g__Labsim_simulation_properties);
	  	print "\n==[ Ocean::var::g__Labsim_language_UUID ]==\n".Dumper(@Ocean::var::g__Labsim_language_UUID);
	  	print "\n==[ Ocean::var::g__Labsim_language_UUID_hash ]==\n".Dumper(%Ocean::var::g__Labsim_language_UUID_hash);
	  	print "\n==[ Ocean::var::g__Labsim_dataset_UUID ]==\n".Dumper(@Ocean::var::g__Labsim_dataset_UUID);
	  	print "\n==[ Ocean::var::g__Labsim_dataset_UUID_hash ]==\n".Dumper(%Ocean::var::g__Labsim_dataset_UUID_hash);
	  	print "\n==[ Ocean::var::g__Thetys_dataset_UUID ]==\n".Dumper(@Ocean::var::g__Thetys_dataset_UUID);
		print "\n==[ Ocean::var::g__Thetys_dataset_UUID_hash ]==\n".Dumper(%Ocean::var::g__Thetys_dataset_UUID_hash);
	  	print "\n==[ Ocean::var::g__Labsim_unitset_UUID ]==\n".Dumper(@Ocean::var::g__Labsim_unitset_UUID);
	  	print "\n==[ Ocean::var::g__Labsim_unitset_UUID_hash ]==\n".Dumper(%Ocean::var::g__Labsim_unitset_UUID_hash);

	}
	
} # DumpVar()

# end module
1;
__END__
