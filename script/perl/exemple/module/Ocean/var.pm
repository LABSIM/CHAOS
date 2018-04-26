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
package Ocean::var;

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
    our @EXPORT_OK   =  qw( 
    	$g__debug_flag 
    	$g__dump_flag 
    	$g__frontend_flag
    	$g__backend_flag
    	$g__custom_experiment_dir 
    	$g__custom_project_dir
		%g__Labsim_files_properties 
		%g__Labsim_model_properties 
		@g__Labsim_language_UUID 
		%g__Labsim_language_UUID_hash
		@g__Labsim_dataset_UUID 
		%g__Labsim_dataset_UUID_hash 
		@g__Thetys_dataset_UUID 
		%g__Thetys_dataset_UUID_hash
		@g__Labsim_unitset_UUID 
		%g__Labsim_unitset_UUID_hash
	);
    
}

# ------------------------------------
# OCEAN variables package
# ------------------------------------
#
# Ce fichier contient l'ensemble des variables globales necéssaires 
#
# author : 	Nawfel Kinani
# creation: 23/02/15
# group : 	Onera DCSD/PSEV LabSim
#

# Flags
our $g__debug_flag 		= 0; # 1 si la sauvegarde des fichiers temporaires est demandé, 0 par defaut
our $g__dump_flag 		= 0; # 1 si le dump des variables est demandé, 0 par defaut
#our $g__frontend_flag 	= 1; # 1 si la generation du frontend est demande, 1 par defaut
#our $g__backend_flag	= 0; # 1 si la generation du backend est demande, 0 par defaut

# Custom paths properties
our $g__custom_experiment_dir	= "";	# contient le path complet vers le répertoire des input XML de la simulation
our $g__custom_project_dir		= "";	# contient le path complet vers le répertoire de sortie de la simulation
	
# la table de hash des fichiers
        
our %g__Labsim_files_properties = (

	# general experiment properties
	XML => {
		SLU => "",
		HCU => ""
	},
	
	# Specific Model Frontend
	Frontend => [{
		
		# Alias
		Alias => "",
		
		# XML
		XML => {
			ALU	=> ""
		},
	
		# Google protocol buffer
		Proto => { Origin => "", Temporary => "", Destination => "" },
		
		# CMake
		CMake => { Origin => "", Temporary => "", Destination => "" },
	
		# CXX 
		CXX => {
			Header => { Origin => "", Temporary => "", Destination => "" },
			Source => { Origin => "", Temporary => "", Destination => "" }
		}
		
	}], # Frontend

	# Specific Actor backend
	Backend => [{
		
		# Alias
		Alias => "",
		
		# XML
		XML => {
			ALU	=> ""
		},
	
		# Google protocol buffer
		Proto => { Origin => "", Temporary => "", Destination => "" },
		
		# CMake
		CMake => { Origin => "", Temporary => "", Destination => "" },
	
		## CXX
		#CXX => {
		#	Header => { Origin => "", Temporary => "", Destination => "" },
		#	Source => { Origin => "", Temporary => "", Destination => "" }
		#}
		
	}] # Model
	
); # %g__Labsim_files_properties

# Simulation properties

our %g__Labsim_simulation_properties = (

	# ALU properties
	ALU => [{
		UUID 	=> "",
		Alias	=> "",
		Lang 	=> "",
		Slot 	=> {
			Input => [{ 
				UUID 		=> "", 
				Alias 		=> "", 
				Type 		=> "", 
				Unit 		=> "", 
				Description => "", 
				Value 		=> ""
			}],
			Output => [{ 
				UUID 		=> "", 
				Alias 		=> "", 
				Type 		=> "", 
				Unit 		=> "", 
				Description => "", 
				Value 		=> ""
			}]
		}
	}],
	
	# SLU properties
	SLU => {
		Participant => {
			Core => [{
				UUID 		=> "", 
				Alias 		=> "",
				SinkAlias 	=> "" 
			}],
			Actor => [{
				UUID 		=> "", 
				Alias 		=> "", 
				ALUAlias	=> "",
				SinkAlias 	=> "" 
			}],
			Model => [{
				UUID 		=> "", 
				Alias 		=> "", 
				ALUAlias	=> "",
				SinkAlias 	=> "" 
			}]
		},
		Stage => [{ 
			UUID 			=> "", 
			Alias 			=> "", 
			StrandAlias 	=> "",
			Steps			=> [{
				UUID 			=> "", 
				Alias 			=> "", 
				Mode			=> "",
				Step			=> [{
					UUID 			=> "", 
					Alias 			=> "", 		
					ALUAlias		=> ""
				}]
			}] 
		}]
	},
	
	# HCU properties
	HCU => {
		Sink => [{
			UUID 					=> "",
			Alias					=> "",
			NetworkInterfaceAddress => "",
			NetworkInterfaceCard 	=> ""
		}],
		Strand => [{
			UUID 	=> "",
			Alias 	=> "",
			Wire	=> [{
				UUID				=> "",
				sourceALUAlias		=> "",
				sourceALUSlot		=> "",
				destinationALUAlias	=> "",
				destinationALUSlot	=> ""
			}]
		}]
	}
	
); # g__Labsim_simulation_properties

#our %g__Labsim_model_properties = (
#
#	uuid 	=> "",
#	alias	=> "",
#	lang 	=> "",
#	slot 	=> {
#		input => [
#			{ uuid => "", alias => "", type => "", unit => "", description => "", value => ""}
#		],
#		output => [
#			{ uuid => "", alias => "", type => "", unit => "", description => "", value => ""}
#		]
#	}
#	
#);

# langage directives

our @g__Labsim_language_UUID = (

	# compiled
	
	"c",			# C
	"cxx",			# C++
	"csharp",		# C#
	"objc",			# Objective C
	
	# interpreted
	
	"java",			# Java
	"java_android",	# Android Java
	"python",		# Python
	"go",			# Go
	
	# web based
	
	"nodejs",		# NodeJS
	"php",			# PHP
	"ruby",			# Ruby on Rails
	
	# plugin based
	
	"simulink"		# Matlab/Simulink coder plugin integration
	
);

our @g__Labsim_language_c_UUID = ( 
	"c"
);

our @g__Labsim_language_cxx_UUID = ( 
	"cxx",
	"c++",
	"cpp",
	"c_plus_plus",
	"c-plus-plus",
	"c plus plus"
);

our @g__Labsim_language_csharp_UUID = ( 
	"csharp",
	"c#",
	"c_sharp",
	"c-sharp",
	"c sharp"
);

our @g__Labsim_language_objc_UUID = ( 
	"objc",
	"objectivec",
	"obj_c",
	"obj-c",
	"obj c",
	"objective_c",
	"objective-c",
	"objective c"
);

our @g__Labsim_language_java_UUID = ( 
	"java"
);

our @g__Labsim_language_java_android_UUID = ( 
	"android",
	"androidjava",
	"android_java",
	"android-java",
	"android java",
	"javaandroid",
	"java_android",
	"java-android",
	"java android",
);

our @g__Labsim_language_python_UUID = ( 
	"python",
	"py"
);

our @g__Labsim_language_go_UUID = ( 
	"go"
);

our @g__Labsim_language_nodejs_UUID = ( 
	"nodejs",
	"node_js",
	"node-js",
	"node js"
);

our @g__Labsim_language_php_UUID = ( 
	"php"
);

our @g__Labsim_language_ruby_UUID = ( 
	"ruby",
	"rb"
);

our @g__Labsim_language_simulink_UUID = ( 
	"simulink",
	"matlab/simulink",
	"matlab_simulink",
	"matlab-simulink",
	"matlab simulink",
	"simulink/matlab",
	"simulink_matlab",
	"simulink-matlab",
	"simulink matlab"
);

our %g__Labsim_language_UUID_hash = ();

# dataset directives

our @g__Labsim_dataset_UUID = (

	"boolean_",	
	"char_",	
	"octet_",							
	"short_",					
	"unsigned_short_",			
	"long_",		
	"unsigned_long_",			
	"long_long_",				
	"unsigned_long_long_",
	"float_",					
	"double_",
	"string_",
	"vec2f_",
	"vec3f_",
	"vec4f_",
	"matrixf_",
	"vec2d_",
	"vec3d_",
	"vec4d_",
	"matrixd_"
	
);

our @g__Thetys_dataset_UUID = (

	"bool", 										
	"int32",										
	"uint32", 									
	"int32", 									
	"uint32",									
	"int32",										
	"uint32", 									
	"int64", 									
	"uint64", 									
	"float",										
	"double", 										
	"string", 								
	"repeated float", 
	"repeated float",	
	"repeated float",	
	"repeated float",	
	"repeated double",
	"repeated double",
	"repeated double",
	"repeated double"
	
);

our @g__Labsim_dataset_boolean_UUID = ( 
	"bool",  
	"boolean"
);

our @g__Labsim_dataset_char_UUID = ( 
	"char"
);

our @g__Labsim_dataset_octet_UUID = ( 
	"unsigned char",
	"unsigned_char",
	"unsigned-char",
	"uchar",
	"octet"
);

our @g__Labsim_dataset_short_UUID = ( 
	"short"
);

our @g__Labsim_dataset_unsigned_short_UUID = ( 
	"unsigned short",
	"unsigned_short",
	"unsigned-short",
	"ushort"
);

our @g__Labsim_dataset_long_UUID = ( 
	"int",    
	"integer",
	"long",
	"long integer",
	"long_integer",
	"long-integer",
	"long int",
	"long_int",
	"long-int"
);

our @g__Labsim_dataset_unsigned_long_UUID = ( 
	"ulong",
	"unsigned long",
	"unsigned long integer",
	"unsigned_long_integer",
	"unsigned-long-integer",
	"unsigned long int",
	"unsigned_long_int",
	"unsigned-long-int"
);

our @g__Labsim_dataset_long_long_UUID = ( 
	"longlong",
	"long long",
	"long_long",
	"long-long",
	"long long integer",
	"long_long_integer",
	"long-long-integer",
	"long long int",
	"long_long_int",
	"long-long-int"
);

our @g__Labsim_dataset_unsigned_long_long_UUID = ( 
	"ulonglong",
	"unsigned long long",
	"unsigned_long_long",
	"unsigned-long-long",
	"unsigned long long integer",
	"unsigned_long_long_integer",
	"unsigned-long-long-integer",
	"unsigned long long int",
	"unsigned_long_long_int",
	"unsigned-long-long-int"
);

our @g__Labsim_dataset_float_UUID = ( 
	"float",
	"flt"
);

our @g__Labsim_dataset_double_UUID = ( 
	"double",
	"dbl"
);

our @g__Labsim_dataset_string_UUID = ( 
	"string",
	"str"
);

our @g__Labsim_dataset_vec2f_UUID = ( 
	"vec2f"
);

our @g__Labsim_dataset_vec3f_UUID = ( 
	"vec3f"
);

our @g__Labsim_dataset_vec4f_UUID = ( 
	"vec4f"
);

our @g__Labsim_dataset_matrixf_UUID = ( 
	"matrixf",
	"matf"
);

our @g__Labsim_dataset_vec2d_UUID = ( 
	"vec2d",
	"vec2"
);

our @g__Labsim_dataset_vec3d_UUID = ( 
	"vec3d",
	"vec3"
);

our @g__Labsim_dataset_vec4d_UUID = ( 
	"vec4d",
	"vec4"
);

our @g__Labsim_dataset_matrixd_UUID = ( 
	"matrixd",
	"matrix",
	"mat"
);

our %g__Labsim_dataset_UUID_hash = ();

our %g__Thetys_dataset_UUID_hash = ();

# unit directives

our @g__Labsim_unitset_UUID = (

	# Sans unite
	"undefined_",

	# acceleration
	"meter_per_square_second_",
	"foot_per_square_second_",
	
	# angular acceleration
	"radian_per_square_second_",
	"degree_per_square_second_",
	
	# angular velocity
	"radian_per_second_",
	"degree_per_second_",
	"revolution_per_minute_",
	
	# area
	"square_meter_",
	"square_kilometer_",
	"square_centimeter_",
	"square_millimeter_",
	"square_foot_",
	"square_inch_",
	"square_mile_",
	"square_yard_",
	
	# energy
	"joule_",
	"kilojoule_",
	"calorie_",
	"kilowatt_per_hour_",
	"watt_per_hour_",
	
	# force
	"newton_",
	"kilonewton_",
	"dekanewton_",
	"pound_force_",
	
	# length
	"meter_",
	"kilometer_",
	"centimeter_",
	"millimeter_",
	"foot_",
	"inch_",
	"mile_",
	"yard_",
	
	# mass
	"kilogram_",
	"metric_ton_",
	"hectogram_",
	"dekagram_",
	"gram_",
	"centigram_",
	"once_",
	"pound_",
	
	# plane angle
	"radian_",
	"degree_",
	
	# power
	"watt_",
	"kilowatt_",
	"horsepower_",
	
	# pressure
	"pascal_",
	"kilopascal_",
	"hectopascal_",
	"bar_",
	"standard_atmosphere_",
	
	# temperature
	"kelvin_",
	"celsuis_",
	"fahrenheit_",
	
	# time
	"second_",
	"minute_",
	"hour_",
	"day_",
	"julian_year_",
	"millisecond_",
	"microsecond_",
	"nanosecond_",
	
	# torque
	"newton_meter_",
	"kilonewton_meter_",
	"dekanewton_meter_",
	
	# velocity
	"meter_per_second_",
	"meter_per_minute_",
	"kilometer_per_hour_",
	"foot_per_minute_",
	"mile_per_hour_",
	"knot_",
	"mach_",
	
	# volume
	"cubic_meter_",
	"cubic_kilometer_",
	"cubic_centimeter_",
	"cubic_millimeter_",
	"cubic_foot_",
	"cubic_inch_",
	"cubic_mile_",
	"cubic_yard_",
	"gallon_",
	"liter_"
		
);

our @g__Labsim_unitset_undefined_UUID = (
	"undefined",
	"none",
	"su"
);

our @g__Labsim_unitset_meter_per_square_second_UUID = (
	"m/s2",
	"m/s^2",
	"m.s-2",
	"m.s^-2",
	"meter-per-square-second",
	"meter_per_square_second",
	"meter per square second"
);

our @g__Labsim_unitset_foot_per_square_second_UUID = ( 
	"ft/s2",
	"ft/s^2",
	"ft.s-2",
	"ft.s^-2",
	"foot-per-square-second",
	"foot_per_square_second",
	"foot per square second"
);

our @g__Labsim_unitset_radian_per_square_second_UUID = (
	"rad/s2",
	"rad/s^2",
	"rad.s-2",
	"rad.s^-2",
	"radian-per-square-second", 
	"radian_per_square_second", 
	"radian per square second"
);

our @g__Labsim_unitset_degree_per_square_second_UUID = ( 
	"deg/s2",
	"deg/s^2",
	"deg.s-2",
	"deg.s^-2",
	"degree-per-square-second",
	"degree_per_square_second",
	"degree per square second"
);

our @g__Labsim_unitset_radian_per_second_UUID = (
	"rad/s",
	"rad.s-1",
	"rad.s^-1",
	"radian-per-second",
	"radian_per_second",
	"radian per second"
);

our @g__Labsim_unitset_degree_per_second_UUID = ( 
	"deg/s",
	"deg.s-1",
	"deg.s^-1",
	"degree-per-second",
	"degree_per_second",
	"degree per second"
);

our @g__Labsim_unitset_revolution_per_minute_UUID = ( 
	"rpm",
	"r/min",
	"r.min-1",
	"r.min^-1",
	"revolution_per_minute",
	"revolution-per-minute",
	"revolution per minute"
);

our @g__Labsim_unitset_square_meter_UUID = ( 
	"m2",	
	"m^2",	
	"square_meter",
	"square-meter",
	"square meter"
);

our @g__Labsim_unitset_square_kilometer_UUID = (
	"km2",	
	"km^2",	
	"square_kilometer",
	"square-kilometer",
	"square kilometer"
);

our @g__Labsim_unitset_square_centimeter_UUID = ( 
	"cm2",	
	"cm^2",	
	"square_centimeter",
	"square-centimeter",
	"square centimeter"
);

our @g__Labsim_unitset_square_millimeter_UUID = ( 
	"mm2",	
	"mm^2",	
	"square_millimeter",
	"square-millimeter",
	"square millimeter"
);

our @g__Labsim_unitset_square_foot_UUID = (
	"ft2",	
	"ft^2",	
	"square_foot",
	"square-foot",
	"square foot"
);

our @g__Labsim_unitset_square_inch_UUID = ( 
	"in2",	
	"in^2",	
	"square_inch",
	"square-inch",
	"square inch"
);

our @g__Labsim_unitset_square_mile_UUID = ( 
	"mi2",	
	"mi^2",	
	"square_mile",
	"square-mile",
	"square mile"
);

our @g__Labsim_unitset_square_yard_UUID = ( 
	"yd2",	
	"yd^2",	
	"square_yard",
	"square-yard",
	"square yard"
);

our @g__Labsim_unitset_joule_UUID = (
	"j",
	"joule"
);

our @g__Labsim_unitset_kilojoule_UUID = ( 
	"kj",
	"kilojoule"
);

our @g__Labsim_unitset_calorie_UUID = ( 
	"cal",
	"calorie"
);

our @g__Labsim_unitset_kilowatt_per_hour_UUID = (
	"kw/h",
	"kw.h-1",
	"kw.h^-1",
	"kilowatt_per_hour",
	"kilowatt-per-hour",
	"kilowatt per hour"
);

our @g__Labsim_unitset_watt_per_hour_UUID = ( 
	"w/h",
	"w.h-1",
	"w.h^-1",
	"watt_per_hour",
	"watt-per-hour",
	"watt per hour"
);

our @g__Labsim_unitset_newton_UUID = ( 
	"n",
	"newton"
);

our @g__Labsim_unitset_kilonewton_UUID = (
	"kn",
	"kilonewton"
);

our @g__Labsim_unitset_dekanewton_UUID = ( 
	"dan",
	"dekanewton"
);

our @g__Labsim_unitset_pound_force_UUID = (
	"lbf",
	"pound_force",
	"pound-force",
	"pound force"
);
		
our @g__Labsim_unitset_meter_UUID = ( 
	"m",
	"meter"
);

our @g__Labsim_unitset_kilometer_UUID = ( 
	"km",
	"kilometer"
);

our @g__Labsim_unitset_centimeter_UUID = ( 
	"cm",
	"centimeter"
);

our @g__Labsim_unitset_millimeter_UUID = ( 
	"mm",
	"millimeter"
);

our @g__Labsim_unitset_foot_UUID = (
	"ft",
	"foot"
);

our @g__Labsim_unitset_inch_UUID = (
	"in",
	"inch"
);

our @g__Labsim_unitset_mile_UUID = ( 
	"mi",
	"mile"
);

our @g__Labsim_unitset_yard_UUID = (
	"yd",
	"yard"
);
		
our @g__Labsim_unitset_kilogram_UUID = (
	"kg",
	"kilogram"
);

our @g__Labsim_unitset_metric_ton_UUID = ( 
	"t",
	"ton",
	"metric-tom",
	"metric_ton",
	"metric ton"
);

our @g__Labsim_unitset_hectogram_UUID = ( 
	"hg",
	"hectogram"
);

our @g__Labsim_unitset_dekagram_UUID = ( 
	"dag",
	"dekagram"
);

our @g__Labsim_unitset_gram_UUID = ( 
	"g",
	"gram"
);

our @g__Labsim_unitset_centigram_UUID = ( 
	"cg",
	"centigram"
);

our @g__Labsim_unitset_once_UUID = ( 
	"oz",
	"once"
);

our @g__Labsim_unitset_pound_UUID = ( 
	"lb",
	"pound"
);
		
our @g__Labsim_unitset_radian_UUID = ( 
	"rad",
	"radian"
);

our @g__Labsim_unitset_degree_UUID = ( 
	"deg",
	"degree"
);

our @g__Labsim_unitset_watt_UUID = ( 
	"w",
	"watt"
);

our @g__Labsim_unitset_kilowatt_UUID = ( 
	"kw",
	"kilowatt"
);

our @g__Labsim_unitset_horsepower_UUID = ( 
	"hp",
	"horsepower"
);

our @g__Labsim_unitset_pascal_UUID = ( 
	"pa",
	"pascal"
);

our @g__Labsim_unitset_kilopascal_UUID = ( 
	"kpa",
	"kilopascal"
);

our @g__Labsim_unitset_hectopascal_UUID = ( 
	"hpa",
	"hectopascal"
);

our @g__Labsim_unitset_bar_UUID = ( 
	"bar"
);

our @g__Labsim_unitset_standard_atmosphere_UUID = ( 
	"atm",
	"standard-atmosphere",
	"standard_atmosphere",
	"standard atmosphere"
);

our @g__Labsim_unitset_kelvin_UUID = ( 
	"k",
	"kelvin"
);

our @g__Labsim_unitset_celsuis_UUID = ( 
	"c",
	"celcius"
);

our @g__Labsim_unitset_fahrenheit_UUID = ( 
	"f",
	"fahrenheit"
);
	
our @g__Labsim_unitset_second_UUID = ( 
	"s",
	"second"
);

our @g__Labsim_unitset_minute_UUID = ( 
	"min",
	"minute"
);

our @g__Labsim_unitset_hour_UUID = ( 
	"h",
	"hour"
);

our @g__Labsim_unitset_day_UUID = ( 
	"d",
	"day"
);

our @g__Labsim_unitset_julian_year_UUID = ( 
	"a",	
	"julian-year",
	"julian_year",
	"julian year"
);

our @g__Labsim_unitset_millisecond_UUID = ( 
	"ms",
	"millisecond"
);

our @g__Labsim_unitset_microsecond_UUID = ( 
	"μs",
	"microsecond"
);

our @g__Labsim_unitset_nanosecond_UUID = (
	"ns",
	"nanosecond"
);
		
our @g__Labsim_unitset_newton_meter_UUID = ( 
	"nm",
	"n.m",
	"newton_meter",
	"newton-meter",
	"newton meter"
);

our @g__Labsim_unitset_kilonewton_meter_UUID = ( 
	"knm",
	"kn.m",
	"kilonewton_meter",
	"kilonewton-meter",
	"kilonewton meter"
);

our @g__Labsim_unitset_dekanewton_meter_UUID = ( 
	"danm",
	"dan.m",
	"dekanewton_meter",
	"dekanewton-meter",
	"dekanewton meter"
);		
our @g__Labsim_unitset_meter_per_second_UUID = ( 
	"m/s",
	"m.s-1",
	"m.s^-1",
	"meter_per_second",
	"meter-per-second",
	"meter per second"
);

our @g__Labsim_unitset_meter_per_minute_UUID = ( 
	"m/min",
	"m.min-1",
	"m.min^-1",
	"meter_per_minute",
	"meter-per-minute",
	"meter per minute"
);

our @g__Labsim_unitset_kilometer_per_hour_UUID = ( 
	"km/h",
	"km.h-1",
	"km.h^-1",
	"kilometer_per_hour",
	"kilometer-per-hour",
	"kilometer per hour"
);

our @g__Labsim_unitset_foot_per_minute_UUID = ( 
	"ft/min",
	"ft.min-1",
	"ft.min^-1",
	"foot_per_minute",
	"foot-per-minute",
	"foot per minute"
);

our @g__Labsim_unitset_mile_per_hour_UUID = ( 
	"mi/h",
	"mi.h-1",
	"mi.h^-1",
	"mile_per_hour",
	"mile-per-hour",
	"mile per hour"
);

our @g__Labsim_unitset_knot_UUID = ( 
	"kn",
	"knot"
);

our @g__Labsim_unitset_mach_UUID = ( 
	"ma",
	"mach"
);
		
our @g__Labsim_unitset_cubic_meter_UUID = ( 
	"m3",
	"m^3",
	"cubic_meter",
	"cubic-meter",
	"cubic meter"
);

our @g__Labsim_unitset_cubic_kilometer_UUID = ( 
	"km3",
	"km^3",
	"cubic_kilometer",
	"cubic-kilometer",
	"cubic kilometer"
);

our @g__Labsim_unitset_cubic_centimeter_UUID = ( 
	"cm3",
	"cm^3",
	"cubic_centimeter",
	"cubic-centimeter",
	"cubic centimeter"
);

our @g__Labsim_unitset_cubic_millimeter_UUID = ( 
	"mm3",
	"mm^3",
	"cubic_millimeter",
	"cubic-millimeter",
	"cubic millimeter"
);

our @g__Labsim_unitset_cubic_foot_UUID = ( 
	"ft3",
	"ft^3",
	"cubic_foot",
	"cubic-foot",
	"cubic foot"
);

our @g__Labsim_unitset_cubic_inch_UUID = ( 
	"in3",
	"in^3",
	"cubic_inch",
	"cubic-inch",
	"cubic inch"
);

our @g__Labsim_unitset_cubic_mile_UUID = ( 
	"mi3",
	"mi^3",
	"cubic_mile",
	"cubic-mile",
	"cubic mile"
);

our @g__Labsim_unitset_cubic_yard_UUID = ( 
	"yd3",
	"yd^3",
	"cubic_yard",
	"cubic-yard",
	"cubic yard"
);

our @g__Labsim_unitset_gallon_UUID = ( 
	"gal",
	"gallon"
);

our @g__Labsim_unitset_liter_UUID = ( 
	"l",
	"liter"
);

our %g__Labsim_unitset_UUID_hash = ();
 
# end module
1;
__END__

