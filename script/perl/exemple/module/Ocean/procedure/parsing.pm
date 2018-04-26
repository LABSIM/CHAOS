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
package Ocean::procedure::parsing;

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
    our @EXPORT_OK   =  qw(XML);
    
}  

# OCEAN packages
use lib qw(../../../module);
use Ocean::system; 
use Ocean::var; 
use Ocean::default;

# useful package
use IPC::System::Simple;
use XML::SimpleObject::LibXML;
use Switch;

# ------------------------------------
# OCEAN Parsing package
# ------------------------------------
#
# Ce fichier contient l'ensemble des routines de parsing des fichiers d'entrées en fonction de nos tokens
#
# author : 	Nawfel Kinani
# creation: 23/02/15
# group : 	Onera DCSD/PSEV LabSim
#

#sub XML_ALU {
#	
#	# ===================== #
#	# XML properties
#	# ===================== #
#	my $xml_file			= $Ocean::var::g__Labsim_files_properties{xml}{ALU}{temporary};
#	my $xml_parser 			= new XML::LibXML;
#	my $xml_dom				= $xml_parser->parse_file($xml_file);
#	my $xml_simple_object	= new XML::SimpleObject::LibXML($xml_dom);
#	# ===================== #
#		
#	# get model properties
#	$Ocean::var::g__Labsim_model_properties{uuid} 	= $xml_simple_object->child("ArithmeticLogicUnit")->attribute('uuid');
#	$Ocean::var::g__Labsim_model_properties{alias} 	= $xml_simple_object->child("ArithmeticLogicUnit")->attribute('alias');	
#	$Ocean::var::g__Labsim_model_properties{lang} 	= $Ocean::var::g__Labsim_language_UUID_hash{ Ocean::system::TrimAndLowercase( $xml_simple_object->child("ArithmeticLogicUnit")->attribute('lang')  ) };
#	
#	# set destination
#	
#	$Ocean::var::g__Labsim_files_properties{proto}{destination} 
#		= Ocean::system::CleanPath(
#			$Ocean::var::g__custom_project_dir."/labsim/colosses/".$Ocean::var::g__Labsim_model_properties{alias}."/share/proto/Thetys.proto"
#		);
#	
#	$Ocean::var::g__Labsim_files_properties{cmake}{destination} 
#		= Ocean::system::CleanPath(
#			$Ocean::var::g__custom_project_dir."/labsim/colosses/".$Ocean::var::g__Labsim_model_properties{alias}."/share/cmake/model-config.cmake"
#		);
#		
#	$Ocean::var::g__Labsim_files_properties{xml}{ALU}{destination} 
#		= Ocean::system::CleanPath(
#			$Ocean::var::g__custom_project_dir."/labsim/colosses/".$Ocean::var::g__Labsim_model_properties{alias}."/share/xml/ArithmeticLogicUnit.xml"
#		);
#	
#	# import corresponding template model into temporary folder
#	switch($Ocean::var::g__Labsim_model_properties{lang}) {
#		
#		# C
#		case ($Ocean::var::g__Labsim_language_UUID[0]) { 
#			
#		}
#		
#		# C++               
#		case ($Ocean::var::g__Labsim_language_UUID[1]) { 
#			
#			$Ocean::var::g__Labsim_files_properties{cxx}{header}{temporary} = Ocean::system::CleanPath($Ocean::default::TMP_PATH."/cxx/".$Ocean::var::g__Labsim_model_properties{alias}.".hpp");
#			Ocean::system::CopyFile($Ocean::var::g__Labsim_files_properties{cxx}{header}{origin},$Ocean::var::g__Labsim_files_properties{cxx}{header}{temporary});
#			Ocean::system::CheckFile($Ocean::var::g__Labsim_files_properties{cxx}{header}{temporary});
#			
#			$Ocean::var::g__Labsim_files_properties{cxx}{source}{temporary} = Ocean::system::CleanPath($Ocean::default::TMP_PATH."/cxx/".$Ocean::var::g__Labsim_model_properties{alias}.".cpp");
#			Ocean::system::CopyFile($Ocean::var::g__Labsim_files_properties{cxx}{source}{origin},$Ocean::var::g__Labsim_files_properties{cxx}{source}{temporary});
#			Ocean::system::CheckFile($Ocean::var::g__Labsim_files_properties{cxx}{source}{temporary});
#			
#			$Ocean::var::g__Labsim_files_properties{cxx}{header}{destination} 
#				= Ocean::system::CleanPath(
#					$Ocean::var::g__custom_project_dir."/labsim/colosses/".$Ocean::var::g__Labsim_model_properties{alias}."/".$Ocean::var::g__Labsim_model_properties{alias}.".hpp"
#				);
#				
#			$Ocean::var::g__Labsim_files_properties{cxx}{source}{destination} 
#				= Ocean::system::CleanPath(
#					$Ocean::var::g__custom_project_dir."/labsim/colosses/".$Ocean::var::g__Labsim_model_properties{alias}."/".$Ocean::var::g__Labsim_model_properties{alias}.".cpp"
#				);
#					
#		}
#		
#		# C#  
#		case ($Ocean::var::g__Labsim_language_UUID[2]) { 
#			
#		}
#		
#		# Objective C
#		case ($Ocean::var::g__Labsim_language_UUID[3]) { 
#			
#		}
#		
#		# Java 
#		case ($Ocean::var::g__Labsim_language_UUID[4]) { 
#			
#		}   
#		                                    
#		# Android Java 
#		case ($Ocean::var::g__Labsim_language_UUID[5]) { 
#			
#		}
#		
#		# Python 
#		case ($Ocean::var::g__Labsim_language_UUID[6]) { 
#			
#		}
#		
#		# Go 
#		case ($Ocean::var::g__Labsim_language_UUID[7]) { 
#			
#		}
#		
#		# NodeJS   
#		case ($Ocean::var::g__Labsim_language_UUID[8]) { 
#			
#		}
#		
#		# PHP
#		case ($Ocean::var::g__Labsim_language_UUID[9]) { 
#			
#		}
#		
#		# Ruby on Rails 
#		case ($Ocean::var::g__Labsim_language_UUID[10]) { 
#			
#		}
#		
#		# Matlab/Simulink coder plugin integration
#		case ($Ocean::var::g__Labsim_language_UUID[11]) { 
#			
#		}
#		
#		# else
#		else {  			
#			print "FUUUUUCK"
#		}
#		
#	} # switch()
#	
#	# parse input
#    my @input = ();
#	foreach my $slot($xml_simple_object->child("ArithmeticLogicUnit")->child("Input")->children) {
#		push @input, {
#			uuid 		=> $slot->attribute('uuid'),
#			alias 		=> $slot->attribute('alias'),
#			type 		=> $Ocean::var::g__Labsim_dataset_UUID_hash{ Ocean::system::TrimAndLowercase( $slot->attribute('type') ) },
#			unit 		=> $Ocean::var::g__Labsim_unitset_UUID_hash{ Ocean::system::TrimAndLowercase( $slot->attribute('unit') ) },
#			description => $slot->attribute('description'),
#			value 		=> $slot->value,
#		};
#	}
#	$Ocean::var::g__Labsim_model_properties{slot}{input} = [ @input ];
#	
#	# parse output
#    my @output = ();
#	foreach my $slot($xml_simple_object->child("ArithmeticLogicUnit")->child("Output")->children) {
#		push @output, {
#			uuid 		=> $slot->attribute('uuid'),
#			alias 		=> $slot->attribute('alias'),
#			type 		=> $Ocean::var::g__Labsim_dataset_UUID_hash{ Ocean::system::TrimAndLowercase( $slot->attribute('type') ) },
#			unit 		=> $Ocean::var::g__Labsim_unitset_UUID_hash{ Ocean::system::TrimAndLowercase( $slot->attribute('unit') ) },
#			description => $slot->attribute('description'),
#			value 		=> $slot->value,
#		};
#	}
#	$Ocean::var::g__Labsim_model_properties{slot}{output} = [ @output ];
#	
#} # XML()

###
# Fonction de parsing du fichier XML-ALU
sub XML_ALU {

	# backend/frontend ... whatever... 1 to 1 binding + same ALU file
	my @ALU_array = ();
	for my $backend_ref( @{ $Ocean::var::g__Labsim_files_properties{Backend} } ) {
		
		# ===================== #
		# XML properties
		# ===================== #
		my $xml_file			= $backend_ref->{XML}{ALU};
		my $xml_parser 			= new XML::LibXML;
		my $xml_dom				= $xml_parser->parse_file($xml_file);
		my $xml_simple_object	= new XML::SimpleObject::LibXML($xml_dom);
		# ===================== #
		
		# parse input
	    my @input_array = ();
	    if($xml_simple_object->child("ArithmeticLogicUnit")->child("Input")) {
			foreach my $input($xml_simple_object->child("ArithmeticLogicUnit")->child("Input")->children) {
				
				push @input_array, {
					UUID 		=> $input->attribute('uuid'),
					Alias 		=> $input->attribute('alias'),
					Type 		=> $Ocean::var::g__Labsim_dataset_UUID_hash{ Ocean::system::TrimAndLowercase( $input->attribute('type') ) },
					Unit 		=> $Ocean::var::g__Labsim_unitset_UUID_hash{ Ocean::system::TrimAndLowercase( $input->attribute('unit') ) },
					Description => $input->attribute('description'),
					Value 		=> $input->value
				};
				
			} # foreach()
		} # if()
		
		# parse output
	    my @output_array = ();
	    if($xml_simple_object->child("ArithmeticLogicUnit")->child("Output")) {
			foreach my $output($xml_simple_object->child("ArithmeticLogicUnit")->child("Output")->children) {
				
				push @output_array, {
					UUID 		=> $output->attribute('uuid'),
					Alias 		=> $output->attribute('alias'),
					Type 		=> $Ocean::var::g__Labsim_dataset_UUID_hash{ Ocean::system::TrimAndLowercase( $output->attribute('type') ) },
					Unit 		=> $Ocean::var::g__Labsim_unitset_UUID_hash{ Ocean::system::TrimAndLowercase( $output->attribute('unit') ) },
					Description => $output->attribute('description'),
					Value 		=> $output->value
				};
			
			} # foreach()
		} # if()
		
		push @ALU_array, {
			UUID 	=> $xml_simple_object->child("ArithmeticLogicUnit")->attribute('uuid'),
			Alias 	=> $xml_simple_object->child("ArithmeticLogicUnit")->attribute('alias'),
			Lang 	=> $Ocean::var::g__Labsim_language_UUID_hash{ Ocean::system::TrimAndLowercase( $xml_simple_object->child("ArithmeticLogicUnit")->attribute('lang') ) },
			Slot	=> { Input => [ @input_array ], Output => [ @output_array ] }
		};
	
	} # for()
	
	# add ALU properties
	$Ocean::var::g__Labsim_simulation_properties{ALU} = [ @ALU_array ];

} # XML_ALU()

###
# Fonction de parsing du fichier XML-SLU
sub XML_SLU {
	
	# ===================== #
	# XML properties
	# ===================== #
	my $xml_file			= $Ocean::var::g__Labsim_files_properties{XML}{SLU};
	my $xml_parser 			= new XML::LibXML;
	my $xml_dom				= $xml_parser->parse_file($xml_file);
	my $xml_simple_object	= new XML::SimpleObject::LibXML($xml_dom);
	# ===================== #
	
	# parse core participant
	my @core_array = ();
	foreach my $core($xml_simple_object->child("SequentialLogicUnit")->child("Participant")->children("Core")) {
		
		push @core_array, {
			UUID 		=> $core->attribute('uuid'),
			Alias 		=> $core->attribute('alias'),
			SinkAlias 	=> $core->attribute('sinkAlias')
		};
		
	} # foreach()
	
	# parse actor participant
	my @actor_array = ();
	foreach my $actor($xml_simple_object->child("SequentialLogicUnit")->child("Participant")->children("Actor")) {
		
		push @actor_array, {
			UUID 		=> $actor->attribute('uuid'),
			Alias 		=> $actor->attribute('alias'),
			ALUAlias 	=> $actor->attribute('ALUAlias'),
			SinkAlias 	=> $actor->attribute('sinkAlias')
		};
		
		# NEW ! Backend
				
		Ocean::function::AddBackendFilesProperties($actor->attribute('ALUAlias'));
		Ocean::function::ValidateBackendOrigin($actor->attribute('ALUAlias'));
		Ocean::function::MakeBackendTemporaryTree($actor->attribute('ALUAlias'));
		Ocean::function::PrepareBackendDestination($actor->attribute('ALUAlias'));
		
	} # foreach()
	
	# dont forget to shift backend empty element
	shift( @{ $Ocean::var::g__Labsim_files_properties{Backend} } );
	
	# parse frontend participant
	my @model_array = ();
	foreach my $model($xml_simple_object->child("SequentialLogicUnit")->child("Participant")->children("Model")) {
		
		push @model_array, {
			UUID 		=> $model->attribute('uuid'),
			Alias 		=> $model->attribute('alias'),
			ALUAlias 	=> $model->attribute('ALUAlias'),
			SinkAlias 	=> $model->attribute('sinkAlias')
		};
		
		# NEW ! Frontend 
		
		Ocean::function::AddFrontendFilesProperties($model->attribute('ALUAlias'));
		Ocean::function::ValidateFrontendOrigin($model->attribute('ALUAlias'));
		Ocean::function::MakeFrontendTemporaryTree($model->attribute('ALUAlias'));
		Ocean::function::PrepareFrontendDestination($model->attribute('ALUAlias'));
		
	} # foreach()
	
	# dont forget to shift frontend empty element
	shift( @{ $Ocean::var::g__Labsim_files_properties{Frontend} } );
	
	# parse stage
	my @stage_array = ();
	foreach my $stage($xml_simple_object->child("SequentialLogicUnit")->children("Stage")) {
		
		# parse steps
		my @steps_array = ();
		foreach my $steps($stage->children("Steps")) {
			
			# parse step
			my @step_array = ();
			foreach my $step($steps->children("Step")) {
				
				push @step_array, {
					UUID 		=> $step->attribute('uuid'),
					Alias 		=> $step->attribute('alias'),
					ALUAlias 	=> $step->attribute('ALUAlias'),
				};
			
			} # foreach()
			
			push @steps_array, {
				UUID 	=> $steps->attribute('uuid'),
				Alias 	=> $steps->attribute('alias'),
				Mode 	=> $steps->attribute('mode'),
				Step 	=> [ @step_array ]
			};
		
		} # foreach()
		 
		push @stage_array, {
			UUID 		=> $stage->attribute('uuid'),
			Alias 		=> $stage->attribute('alias'),
			StrandAlias => $stage->attribute('strandAlias'),
			Steps 		=> [ @steps_array ]
		};
		
	} # foreach()
	
	# add SLU properties
	$Ocean::var::g__Labsim_simulation_properties{SLU}{Participant}{Core} = [ @core_array ];
	$Ocean::var::g__Labsim_simulation_properties{SLU}{Participant}{Actor} = [ @actor_array ];
	$Ocean::var::g__Labsim_simulation_properties{SLU}{Participant}{Model} = [ @model_array ];
	$Ocean::var::g__Labsim_simulation_properties{SLU}{Stage} = [ @stage_array ];
	
} # XML_SLU()

###
# Fonction de parsing du fichier XML-HCU
sub XML_HCU {
	
	# ===================== #
	# XML properties
	# ===================== #
	my $xml_file			= $Ocean::var::g__Labsim_files_properties{XML}{HCU};
	my $xml_parser 			= new XML::LibXML;
	my $xml_dom				= $xml_parser->parse_file($xml_file);
	my $xml_simple_object	= new XML::SimpleObject::LibXML($xml_dom);
	# ===================== #
	
	# parse sink
	my @sink_array = ();
	foreach my $sink($xml_simple_object->child("HardwireControlUnit")->children("Sink")) {
		
		push @sink_array, {
			UUID 					=> $sink->attribute('uuid'),
			Alias 					=> $sink->attribute('alias'),
			NetworkInterfaceAddress => $sink->attribute('networkInterfaceAddress'),
			NetworkInterfaceCard 	=> $sink->attribute('networkInterfaceCard')
		};
		
	} # foreach()
	
	# parse strand
	my @strand_array = ();
	foreach my $strand($xml_simple_object->child("HardwireControlUnit")->children("Strand")) {
		
		# parse wire
		my @wire_array = ();
		foreach my $wire($strand->children) {
		
			push @wire_array, {
				UUID 				=> $wire->attribute('uuid'),
				SourceALUAlias 		=> $wire->attribute('sourceALUAlias'),
				SourceALUSlot 		=> $wire->attribute('sourceALUSlot'),
				DestinationALUAlias	=> $wire->attribute('destinationALUAlias'),
				DestinationALUSlot 	=> $wire->attribute('destinationALUSlot')
			};
		
		} # foreach()
		
		push @strand_array, {
			UUID 	=> $strand->attribute('uuid'),
			Alias 	=> $strand->attribute('alias'),
			Wire	=> [ @wire_array ]
		};
		
	} # foreach()
	
	# add HCU properties
	$Ocean::var::g__Labsim_simulation_properties{HCU}{Sink} = [ @sink_array ];
	$Ocean::var::g__Labsim_simulation_properties{HCU}{Strand} = [ @strand_array ];
	
} # XML_HCU()

###
# Fonction de parsing des fichiers XML
sub XML {
	
	XML_SLU();
	XML_HCU();
	XML_ALU();
	
} # XML()

# end module
1;
__END__

