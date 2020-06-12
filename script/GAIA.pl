#!/usr/bin/perl -w

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

# perl version
use 5.026;

# force declaration, warnings & print error diagnostics
use strict;
use warnings;
use diagnostics -verbose;

# module
use FindBin qw($RealBin);   		# facilities
use Switch;                         # switch statement handling
use Env;							# environment variables manipulation
use Config;							# Perl configuration module (OS/Arch/...)
use Graph;							# graph data structures and algorithms (dependancies solver)
use Getopt::Long qw(GetOptions);    # avoid name-space pollution
use Pod::Usage qw(pod2usage);		# usage pretty print
use Term::ANSIColor qw(:constants); # colored output for the terminal
use File::Spec;                     # file Op
use File::HomeDir;                  # home
use Time::HiRes qw(time);			# high-resolution timer
use Data::Dumper;					# dump functionality
use List::Util qw(any);				# find any string in array
use IPC::Cmd qw[can_run run QUOTE];	# system independant command execution

# configure
Getopt::Long::Configure qw(gnu_getopt);

# global program-wide constant
use constant {
	
	GAIA_EXIT_SUCCESS        => 0,
	GAIA_EXIT_ERROR          => 1,
	GAIA_EXIT_CRITICAL_ERROR => 2
	
};

#-----------------------------------------------------------------------------
# Data structure
#
our %g__Labsim_ecosystem_properties = (

	Ecosystem => [{
		
		Name     => "",
		Detail   => "",
		Feature  => [{
			
			Name        => "",
			Priority    => "",
			Third_party => [{
				
				Name     => "",
				Priority => "",
				Major    => "",
				Minor    => "",
				Patch    => ""
				
			}]
		
		}]
	
	}]	

);

#-----------------------------------------------------------------------------
# Argument / Variable
#

# arg
my $arg_help_flag                 = 0; 
my $arg_man_flag                  = 0; 
my $arg_listAvailable_flag        = 0;
my $arg_detailledEcosystem_flag   = 0; 
my $arg_detailledEcosystem_string = "";
my $arg_targetEcosystem_flag      = 0; 
my $arg_targetEcosystem_string    = "";
my $arg_targetFeature_flag        = 0; 
my @arg_targetFeature_array       = (); 
my $arg_dev_mode                  = 0;

# root
my $var_gaia_root = function_CleanPath($FindBin::RealBin."/..");
	
#-----------------------------------------------------------------------------
# Logging
#

# constant
use constant {

	GAIA_VERBOSITY_NONE     => 0,
	GAIA_VERBOSITY_ERROR    => 1,
	GAIA_VERBOSITY_WARNING  => 2,
	GAIA_VERBOSITY_INFO     => 3,
	GAIA_VERBOSITY_DEBUG    => 4

};

# default value
my $gaia_verbosity_level = GAIA_VERBOSITY_INFO;

# check log level
sub has_Debug   { return ( $gaia_verbosity_level >= GAIA_VERBOSITY_DEBUG   ); }
sub has_Info    { return ( $gaia_verbosity_level >= GAIA_VERBOSITY_INFO    ); }
sub has_Warning { return ( $gaia_verbosity_level >= GAIA_VERBOSITY_WARNING ); }
sub has_Error   { return ( $gaia_verbosity_level >= GAIA_VERBOSITY_ERROR   ); }

# ------- logging functions ------- 

sub log_Debug   { 
	
	# pretty print
	say( 
		RESET, CYAN, time(), 
		RESET, "|", GREEN, shift."()", 
		RESET, " ",
		RESET, BOLD, MAGENTA, "[GAIA] -- DEBUG : ", RESET, @_ 
	) if has_Debug(); 
	
	return; 

} # log_Debug()

sub log_Info    { 
	
	if( has_Debug() ) {
		
		# pretty print
		say( 
			RESET, CYAN, time(), 
			RESET, "|", GREEN, shift."()", 
			RESET, " ",
			RESET, BOLD, BLUE, "[GAIA] -- INFO : ", RESET, @_ 
		) if has_Info(); 
	
	} else {
		
		# discard 1st
		shift;
		
		# pretty print
		say(RESET, BOLD, BLUE, "[GAIA] -- INFO : ", RESET, @_) if has_Info(); 
	
	} # if()
	
	return;
	
} # log_Info()

sub log_Warning { 
	
	if( has_Debug() ) {
		
		# pretty print
		say( 
			RESET, CYAN, time(), 
			RESET, "|", GREEN, shift."()", 
			RESET, " ",
			RESET, BOLD, YELLOW, "[GAIA] -- WARNING : ", RESET, @_ 
		) if has_Warning(); 
		
	} else {
		
		# discard 1st
		shift;
		
		# pretty print
		say(RESET, BOLD, YELLOW, "[GAIA] -- WARNING : ", RESET, @_) if has_Warning(); 
		
	} # if()
	
	return;
	
} # log_Warning()

sub log_Error   { 
	
	if( has_Debug() ) {
		
		# pretty print
		say( 
			RESET, CYAN, time(), 
			RESET, "|", GREEN, shift."()", 
			RESET, " ",
			RESET, BOLD, WHITE, ON_RED, "[GAIA] -- ERROR :", RESET, " ", @_ 
		) if has_Error();
		
	} else {
		
		# discard 1st
		shift;
		
		# pretty print
		say(RESET, BOLD, WHITE, ON_RED, "[GAIA] -- ERROR :", RESET, " ", @_) if has_Error(); 
   
	} # if()
	
	# exit
	exit(GAIA_EXIT_ERROR);
	
} # log_Error()

#-----------------------------------------------------------------------------
# function_ConfigureRuntimeModule
#
sub function_ConfigureRuntimeModule {
	
	# general flag
	my $requirements_flag = 1;
	
	# Win32 support for ANSI terminal
	if($Config{osname} eq "MSWin32") {
		
		my $requirement_win32_flag = eval { require Win32::Console::ANSI; Win32::Console::ANSI->import(); 1; };
		if(!$requirement_win32_flag) {
			
			print("[GAIA] -- ERROR : module [Win32::Console::ANSI] unavailable, maybe you should install it ? try command [perl -MCPAN -e 'install Win32::Console::ANSI']...\n");
			$requirements_flag = 0;
		
		} # if()
	
	} # if()

	# exit on error
	exit(GAIA_EXIT_CRITICAL_ERROR) if(!$requirements_flag);
	
} # function_ConfigureRuntimeModule()

#-----------------------------------------------------------------------------
# Command line
#

# command line parsing op
sub function_ParseCommandLine {

	# define arguments
    Getopt::Long::GetOptions(

        'list-available|l' => sub {

			# extract
			my ($arg_name, $arg_value) = @_;
			$arg_listAvailable_flag    = $arg_value;
			
			# check exclusivity
			log_Error("function_ParseCommandLine","specify only --list-available or --detailled-ecosystem") if($arg_detailledEcosystem_flag);
			
			# check incompatibility
			log_Error("function_ParseCommandLine","found --list-available option but incompatible --target-ecosystem option detected ! check your command-line...") if($arg_targetEcosystem_flag);
			log_Error("function_ParseCommandLine","found --list-available option but incompatible --enable-feature option detected ! check your command-line...") if($arg_targetFeature_flag);
	
        },
        'detailled-ecosystem|d=s' => sub {

			# extract
			my ($arg_name, $arg_value)     = @_;
			$arg_detailledEcosystem_flag   = 1;
			$arg_detailledEcosystem_string = $arg_value;
			
			# check exclusivity
			log_Error("function_ParseCommandLine","specify only --list-available or --detailled-ecosystem") if($arg_listAvailable_flag);
			
			# check incompatibility
			log_Error("function_ParseCommandLine","found --detailled-ecosystem option but incompatible --target-ecosystem option detected ! check your command-line...") if($arg_targetEcosystem_flag);
			log_Error("function_ParseCommandLine","found --detailled-ecosystem option but incompatible --enable-feature option detected ! check your command-line...") if($arg_targetFeature_flag);
	
        },
        'target-ecosystem|t=s' => sub {
        	
        	# extract
			my ($arg_name, $arg_value)  = @_;
			$arg_targetEcosystem_flag   = 1;
			$arg_targetEcosystem_string = $arg_value;
			
			# check incompatibility
			log_Error("function_ParseCommandLine","found --target-ecosystem option but incompatible --detailled-ecosystem option detected ! check your command-line...") if($arg_detailledEcosystem_flag);
			log_Error("function_ParseCommandLine","found --target-ecosystem option but incompatible --list-available option detected ! check your command-line...") if($arg_listAvailable_flag);
	
        },
        'enable-feature|e=s@' => sub {
        	
        	# extract
        	my ($arg_name) = shift;
        	$arg_targetFeature_flag = 1;
			push(@arg_targetFeature_array, split(/,/,join(',',@_)));

			# check incompatibility
			log_Error("function_ParseCommandLine","found --enable-feature option but incompatible --detailled-ecosystem option detected ! check your command-line...") if($arg_detailledEcosystem_flag);
			log_Error("function_ParseCommandLine","found --enable-feature option but incompatible --list-available option detected ! check your command-line...") if($arg_listAvailable_flag);

        },
        'verbosity-level|v=s' => sub {

			my ($arg_name, $arg_value) = @_;
			switch($arg_value) {
				case "none"    { $gaia_verbosity_level = GAIA_VERBOSITY_NONE;    }
				case "error"   { $gaia_verbosity_level = GAIA_VERBOSITY_ERROR;   }
				case "warning" { $gaia_verbosity_level = GAIA_VERBOSITY_WARNING; }
				case "info"    { $gaia_verbosity_level = GAIA_VERBOSITY_INFO;    }
				case "debug"   { $gaia_verbosity_level = GAIA_VERBOSITY_DEBUG;   }
				case "dev"     { 
					$gaia_verbosity_level = GAIA_VERBOSITY_DEBUG; 
					$arg_dev_mode =1; 
					log_Info("YouAreInsideTheMatrix","oh oh oh, is see... You're a man of culture :)");
					log_Info("YouAreInsideTheMatrix","I'm trying to free your mind, Neo. But I can only show you the door. You're the one that has to walk through it.");
				} # kind of a hidden spot :)
				else {
					log_Error("function_ParseCommandLine","User-specified verbosity-level incorectly parsed. Unspecified options set to default [info] verbosity value. Authorized values are [none, error, warn, info, debug]");
				}                                                                                 
			} # switch()
        },
        'help|h' => \$arg_help_flag,
        'man'    => \$arg_man_flag,

    ) or Pod::Usage::pod2usage( { -exitval => GAIA_EXIT_CRITICAL_ERROR } );
    
    # check default usage options
	Pod::Usage::pod2usage( { -verbose => 1, -exitval => GAIA_EXIT_SUCCESS } ) if $arg_help_flag;
	Pod::Usage::pod2usage( { -verbose => 2, -exitval => GAIA_EXIT_SUCCESS } ) if $arg_man_flag;

} # ParseCmdLine()

#-----------------------------------------------------------------------------
# CleanPath
#

# Subroutines de nettoyage d'un path relatif etc etc
sub function_CleanPath {

	# clean path relatively to the current binary dir, unwind it & return the result
	# cf [ http://www.perlmonks.org/?node_id=362731 ]
	
	my $raw = shift;
	
    my( $volume, $directories, $file ) = File::Spec->splitpath( File::Spec->canonpath( File::Spec->rel2abs( $raw, $FindBin::RealBin ) ) );
    my( @dur ) = File::Spec->splitdir( $directories );
    my @dar;
    
    foreach(@dur){
        if( $_ eq File::Spec->updir() ){
            pop @dar;
        } else {
            push @dar, $_;
        }
    }

    return File::Spec->catpath(
        $volume,
        File::Spec->catdir( @dar ),
        $file
    );
	
} # CleanPath()

#-----------------------------------------------------------------------------
# function_ParseAllAvailableEcosystem
#

sub function_ParseAllAvailableEcosystem {

    log_Debug("function_ParseAllAvailableEcosystem","<===== entry point");
    
	# ecosystem path
	my $ecosystem_root = $var_gaia_root."/ecosystem";
	
    # list top-level available ecosystem
   	opendir(my $ecosystem_hndl, $ecosystem_root) or log_Error("function_ParseAllAvailableEcosystem","opendir(ecosystem_hndl) error : $!");
 	my @available_ecosystem = grep( -d "$ecosystem_root/$_" && ! /^\.{1,2}$/ , readdir($ecosystem_hndl) );
    closedir($ecosystem_hndl); 
    
    log_Debug("function_ParseAllAvailableEcosystem","found available ecosystem [".join(" ", @available_ecosystem)."]");
    
    # Loop through the array
    my @ecosystem_array = ();
    foreach my $ecosystem_name (@available_ecosystem) {
    	
        log_Debug("function_ParseAllAvailableEcosystem","parsing ecosystem name [".$ecosystem_name."]");
        
        # sub ecosystem path
		my $sub_ecosystem_root = $ecosystem_root."/".$ecosystem_name;
		
        log_Debug("function_ParseAllAvailableEcosystem","inspecting [".$sub_ecosystem_root."]");
        
        # get feature & detail 
        opendir(my $sub_ecosystem_hndl, $sub_ecosystem_root) or log_Error("function_ParseAllAvailableEcosystem","opendir(sub_ecosystem_hndl) error : $!");
 		my ($sub_ecosystem_detail_filename, $sub_ecosystem_detail_filename_check) = grep ( /\.md$/, readdir($sub_ecosystem_hndl) );
		if( defined($sub_ecosystem_detail_filename_check) ) {
    		log_Error("function_ParseAllAvailableEcosystem","multiple token found during regex extraction of detail file... you should check the ecosystem [".$ecosystem_name."]");
		} # if()
 		rewinddir($sub_ecosystem_hndl);
	 	my @sub_ecosystem_feature_filename = grep ( /\.feature$/, readdir($sub_ecosystem_hndl) ); 
	    closedir($sub_ecosystem_hndl);
	    
        log_Debug("function_ParseAllAvailableEcosystem","found file detail -> [".$sub_ecosystem_detail_filename."] & file feature -> [".join(" | ", @sub_ecosystem_feature_filename)."]");
                
    	# Loop through the feature
    	my @feature_array = ();
    	foreach my $feature_filename (@sub_ecosystem_feature_filename) {
    		
    		# get only the first feature name (normally, there should be only one...)
    		my ($feature_name, $feature_name_check) = $feature_filename =~ /[0-9]+-third_party-(.*?)\.feature/g;
    		if( defined($feature_name_check) ) {
    			    		
    			log_Warning("function_ParseAllAvailableEcosystem","multiple token found during regex name extraction... [".$feature_filename."] for feature [".$feature_name."] --> found [".$feature_name_check."]");
    		 
    		} # if()

			# get only the first feature priority (normally, there should be only one...)
    		my ($feature_priority, $feature_priority_check) = $feature_filename =~ /([0-9]*?)-third_party-.*\.feature/g;
    		if( defined($feature_priority_check) ) {
    			    		
    			log_Warning("function_ParseAllAvailableEcosystem","multiple token found during regex priority extraction... [".$feature_filename."] for feature [".$feature_priority."] --> found [".$feature_priority_check."]");
    		 
    		} # if()
    		
    		log_Debug("function_ParseAllAvailableEcosystem","inspecting [".$sub_ecosystem_root."/".$feature_filename."] for feature [".$feature_name."] with priority [".$feature_priority."]");
    		 
    		# extract them
    		open(my $third_party_file_hndl, $sub_ecosystem_root."/".$feature_filename) or log_Error("function_ParseAllAvailableEcosystem","open(".$sub_ecosystem_root."/".$feature_filename.") error : $!");
    		my @third_party_file_array;
    		while (my $third_party_file_row = <$third_party_file_hndl>) {
    			chomp $third_party_file_row;
    			push(@third_party_file_array,$third_party_file_row);
    		} # while()
    		close($third_party_file_hndl);
    		
    		log_Debug("function_ParseAllAvailableEcosystem","found third party library -> [".join(" | ", @third_party_file_array)."]");
    		
    		# Loop over third party
    		my @third_party_array = ();
    		for my $third_party_priority (0 .. $#third_party_file_array) {
    			
    			log_Debug("function_ParseAllAvailableEcosystem","spliting row -> [".$third_party_file_array[$third_party_priority]."]");
    			
    			# split thritd party row
    			my ($third_party_name, $third_party_version) = split( / /, $third_party_file_array[$third_party_priority] ); # split on space
    			my ($third_party_major, $third_party_minor, $third_party_patch) = split( /\./, $third_party_version ); # split on dot
    			
    			log_Debug(
    				"function_ParseAllAvailableEcosystem",
    				"found priority -> [".($third_party_priority)."] name -> [".$third_party_name."] version -> [".$third_party_version."] major -> [".$third_party_major."] minor -> [".$third_party_minor."] patch -> [".$third_party_patch."]"
    			);
    			
    			push @third_party_array, {
    				
    				Name     => $third_party_name,
					Priority => $third_party_priority,
					Major    => $third_party_major,
					Minor    => $third_party_minor,
					Patch    => $third_party_patch
    				
    			};
    			    
			} # for()
    		
    		push @feature_array, {
    			
    			Name        => $feature_name,
    			Priority    => $feature_priority,
				Third_party => [ @third_party_array ]
    				
    		};
    		
    	} # foreach()
    	
		push @ecosystem_array, {
    				
    		Name    => $ecosystem_name,
    		Detail  => ( $var_gaia_root."/ecosystem/".$ecosystem_name."/".$sub_ecosystem_detail_filename ),
			Feature => [ @feature_array ]
    				
		};
    
    } # foreach()
    
    # finally assigning 
    $g__Labsim_ecosystem_properties{Ecosystem} = [ @ecosystem_array ];
    
    log_Debug("function_ParseAllAvailableEcosystem","<===== exit point");
    
} # function_ParseAllAvailableEcosystem()

#-----------------------------------------------------------------------------
# function_DumpInternalDatamodel
#

sub function_DumpInternalDatamodel {
	
	# iff. has_debug()
	if( ! has_Debug() ) { return; }

    log_Debug("function_DumpInternalDatamodel","<===== entry point");
    
	$Data::Dumper::Terse 	= 0;        # output names where feasible
	$Data::Dumper::Indent 	= 3;       	# pretty print with array indices
    $Data::Dumper::Useqq 	= 1;        # print strings in double quotes
   	$Data::Dumper::Pair 	= " : ";    # specify hash key/value separator
   	$Data::Dumper::Purity 	= 1;       	# avoid cross-refs
   	$Data::Dumper::Deepcopy = 1; 	 	# avoid cross-refs
   	
   	foreach my $dump_row ( split( /[\n\r]+/ , Dumper( %g__Labsim_ecosystem_properties ) ) ) {
   		log_Debug("function_DumpInternalDatamodel", $dump_row);
   	} # foreach()
    
    log_Debug("function_DumpInternalDatamodel","<===== exit point");
    
} # function_DumpInternalDatamodel()

#-----------------------------------------------------------------------------
# function_DumpCurrentEcosystemDetail
#

sub function_DumpCurrentEcosystemDetail {

    log_Debug("function_DumpCurrentEcosystemDetail","<===== entry point");
    
	$Data::Dumper::Terse 	= 0;        # output names where feasible
	$Data::Dumper::Indent 	= 3;       	# pretty print with array indices
    $Data::Dumper::Useqq 	= 1;        # print strings in double quotes
   	$Data::Dumper::Pair 	= " : ";    # specify hash key/value separator
   	$Data::Dumper::Purity 	= 1;       	# avoid cross-refs
   	$Data::Dumper::Deepcopy = 1; 	 	# avoid cross-refs
   
	open(my $fh, '-|', 'echo -e $GAIA_ECOSYSTEM_DETAIL') or die $!;
	while( my $dump_row = <$fh> ) {
		chomp($dump_row);
   		log_Info("function_DumpCurrentEcosystemDetail", $dump_row);
   	} # while()
    
    log_Debug("function_DumpCurrentEcosystemDetail","<===== exit point");
    
} # function_DumpCurrentEcosystemDetail()

#-----------------------------------------------------------------------------
# function_DumpAvailableEcosystemDetail
#

sub function_DumpAvailableEcosystemDetail {

    log_Debug("function_DumpAvailableEcosystemDetail","<===== entry point");
    
    log_Info("function_DumpAvailableEcosystemDetail","available GAIA simulation software ecosytem are :");
    for my $ecosystem_ref ( @{ $g__Labsim_ecosystem_properties{Ecosystem} } ) {
    	
    	log_Info("function_DumpAvailableEcosystemDetail","  - ".$ecosystem_ref->{Name});
    	
    } # for()
    
    log_Debug("function_DumpAvailableEcosystemDetail","<===== exit point");
    
} # function_DumpAvailableEcosystemDetail()

#-----------------------------------------------------------------------------
# function_DumpDetailledEcosystem
#

sub function_DumpDetailledEcosystem {

    log_Debug("function_DumpDetailledEcosystem","<===== entry point");
    
    # search for requested ecosystem name    
    for my $ecosystem_ref ( @{ $g__Labsim_ecosystem_properties{Ecosystem} } ) {
    	
    	if($ecosystem_ref->{Name} eq $arg_detailledEcosystem_string) {
    	
    		log_Info("function_DumpAvailableEcosystemDetail"," [name] : ".$ecosystem_ref->{Name});
    		log_Info("function_DumpAvailableEcosystemDetail"," [desc] : ".$ecosystem_ref->{Detail});
    		
    		for my $feature_ref ( @{ $ecosystem_ref->{Feature} } ) {
			
    			log_Info("function_DumpAvailableEcosystemDetail"," [feature] : ".$feature_ref->{Name}." (priority : ".$feature_ref->{Priority}.")");
    			
    			for my $third_party_ref ( @{ $feature_ref->{Third_party} } ) {
    				
    				log_Info(
    					"function_DumpAvailableEcosystemDetail",
    					"     |  [third-party] : ".$third_party_ref->{Name}." v".$third_party_ref->{Major}.".".$third_party_ref->{Minor}.".".$third_party_ref->{Patch}." (priority : ".$third_party_ref->{Priority}.")"
    				);
    		
    			} # for()
    			
    		} # for()
    	
    	} # if()
    	
    } # for()
    
    log_Debug("function_DumpAvailableEcosystemDetail","<===== exit point");
    
} # function_DumpDetailledEcosystem()

#-----------------------------------------------------------------------------
# function_DeployTargetEcosystem
#

sub function_DeployTargetEcosystem {

    log_Debug("function_DeployTargetEcosystem","<===== entry point");
    
    # search for requested target ecosystem    
    for my $ecosystem_ref ( @{ $g__Labsim_ecosystem_properties{Ecosystem} } ) {
    	
    	if($ecosystem_ref->{Name} eq $arg_targetEcosystem_string) {
    	
    		log_Info("function_DeployTargetEcosystem","target : ecosystem [".$ecosystem_ref->{Name}."]");
    		
    		for my $feature_ref ( sort { $a->{Priority} <=> $b->{Priority} } @{ $ecosystem_ref->{Feature} } ) { # ( @{ $ecosystem_ref->{Feature} } ) {
    		
    			if( any { /$feature_ref->{Name}/ } @arg_targetFeature_array ) {
    				
    				log_Info("function_DeployTargetEcosystem","  add user-requested feature [".$feature_ref->{Name}."] with priority [".$feature_ref->{Priority}."]");
    				
				    foreach my $third_party_ref ( sort { $a->{Priority} <=> $b->{Priority} } @{ $feature_ref->{Third_party} } ) {
				    
				    	log_Info("function_DeployTargetEcosystem","    processing third_party [".$third_party_ref->{Name}."] with priority [".$third_party_ref->{Priority}."]");
				    	log_Info("function_DeployTargetEcosystem","    ----------------------------------------------<EXTERNAL_SCRIPT>-----------------------------------------------");
				    	
				    	# so now, we can launch the corresponding target shell :)
						# check vcpk, if not use proper script depending of the OS
						my $cmd_line = "";
						if (IPC::Cmd->can_run("vcpkg") eq "") {

							switch( $Config{osname} ) {

								case "linux" {
									log_Info("function_DeployTargetEcosystem","    > vcpkg not available, switching to default script/sh/target/*");
									$cmd_line = [
										IPC::Cmd->can_run("/bin/bash"),
										"-c",
										QUOTE ."source ".$var_gaia_root.'/script/sh/GAIA.bashrc && ${0} ${1+"$@"}'.QUOTE,
										$var_gaia_root."/script/sh/target/install-".$third_party_ref->{Name}.".sh",
										$third_party_ref->{Major},
										$third_party_ref->{Minor},
										$third_party_ref->{Patch}
									];
								} # Linux
								
								case "MSWin32" {
									log_Info("function_DeployTargetEcosystem","    > vcpkg not available, switching to default script/ps1/target/*");
									exit(GAIA_EXIT_ERROR);
								} # Windows
							
								else {
									log_Error("function_DeployTargetEcosystem","unsupported platform !!");
								}
							
							} # switch()

						} else {
							
							log_Info("function_DeployTargetEcosystem","    > vcpkg available ! using it");

						}

				    	# syscall
				    	log_Debug("function_DeployTargetEcosystem","external command -> [ ".join(" ", @$cmd_line)." ]");
						if( scalar IPC::Cmd->run(
								command => join(" ", @$cmd_line),
								verbose => 1
							)
						) {

							log_Info("function_DeployTargetEcosystem","Success !");

						} else {
							
				            log_Error("function_DeployTargetEcosystem","failed to execute: $!");
							exit(GAIA_EXIT_ERROR);

						}
    					
				    	log_Info("function_DeployTargetEcosystem","    ----------------------------------------------</EXTERNAL_SCRIPT>-----------------------------------------------");
				    
				    } # foreach
    				
    			} # if()
    			
    		} # for()
    	
    	} # if()
    	
    } # for()
    
    log_Debug("function_DeployTargetEcosystem","<===== exit point");
    
} # function_DeployTargetEcosystem()

#-----------------------------------------------------------------------------
# Main
#
MAIN:
{	
	
	# first of all, check configure modules & parse command line
	function_ConfigureRuntimeModule();
	function_ParseCommandLine();
	
	# log
	log_Debug("Main","found RealBin=[".$FindBin::RealBin);
	log_Debug("Main","found GAIA root directory -> [".$var_gaia_root."]");
	
	# if not any flag just pretty print current ecosystem detail
	if( !$arg_listAvailable_flag
		&& !$arg_detailledEcosystem_flag
		&& !$arg_targetEcosystem_flag
		&& !$arg_targetFeature_flag
	)  {
		
		log_Debug("Main","begining dumping current ecosystem detail operation");
		function_DumpCurrentEcosystemDetail();
		
		# success
	    log_Debug("Main","Successfully completed all operation. Exiting...");
	    exit(GAIA_EXIT_SUCCESS);
		
	} # if()
	
	# parse
    log_Debug("Main","begining parsing operation");
	function_ParseAllAvailableEcosystem();

	# dump
    log_Debug("Main","begining dumping internal datamodel operation");
	function_DumpInternalDatamodel();
	
	# list available ?
	if($arg_listAvailable_flag) {
	
	    log_Debug("Main","begining dumping available ecosystem operation");
		function_DumpAvailableEcosystemDetail();
		
		# success
	    log_Debug("Main","Successfully completed all operation. Exiting...");
	    exit(GAIA_EXIT_SUCCESS);
		
	} # if()
	
	# print detailled one ?
	if( ($arg_detailledEcosystem_flag) && ($arg_detailledEcosystem_string ne "") ) {
		
		log_Debug("Main","begining dumping user-requested ecosystem operation");
		function_DumpDetailledEcosystem();
		
		# success
	    log_Debug("Main","Successfully completed all operation. Exiting...");
	    exit(GAIA_EXIT_SUCCESS);
		
	} # if()
	
	# normally, there should be only one couple of option available, check if they are both present
	
	log_Error(
		"Main",
		"option --enable-feature should be specified in pair with --target-ecoystem, check your command line and/or RTFM."
	) if( !$arg_targetEcosystem_flag && $arg_targetFeature_flag );
	
	log_Error(
		"Main",
		"option --target-ecosystem should be specified in pair with --enable-feature, check your command line and/or RTFM."
	) if( $arg_targetEcosystem_flag && !$arg_targetFeature_flag );
		
	# it ok, start target installation
	if( $arg_targetEcosystem_flag && $arg_targetFeature_flag ) {
		
		log_Debug("Main","begining deploying user-requested ecosystem operation");
		function_DeployTargetEcosystem();
		
		# success
	    log_Debug("Main","Successfully completed all operation. Exiting...");
	    exit(GAIA_EXIT_SUCCESS);	
		
	} # if()
	
	# hummmm .... this should really never occur...
    log_Warning("Main","The force is with you, young Skywalker. But you are not a Jedi yet !... (Darth Vador et al.)");
    log_Warning("Main","I have a bad feeling about this ! (Han Solo et al.)");
    exit(GAIA_EXIT_ERROR);

} # MAIN

# end 
__END__

=head1 NAME
 
GAIA : required LABSIM ground software ecosystem                  
 
=head1 SYNOPSIS

B<gaia> I<[options]>
 
 Options:
   --verbosity-level|v       script verbosity
   --list-available|l        list all available simulation software ecosystem
   --detailled-ecosystem|d   detailled view of requested ecosystem
   --target-ecosystem|t      the simulation software ecosystem to deploy
   --enable-feature|e        the simulation software ecosystem related feature list to deploy 
   --help|h                  brief help message			
   --man                     full documentation
   
=head1 OPTIONS
 
=over 4

=item -v B<level>, --verbosity-level=B<level> 

 Argument : DEFAULT=[info]
 Level of verbosity. Available level are [none, error, warn, info, debug]

=item -l, --list-available

 List all available simulation software ecosystem listed under the $ENV{GAIA_ROOT}/ecosystem/ directory. Print output & exit.

=item -d B<name>, --detailled-ecosystem=B<name>

 Argument : REQUIRED=[ecosystem_name]
 Print detailled output of requested GAIA simulation software ecosystem.
 
=item -t B<name>, --target-ecosystem=B<name>

 Argument : REQUIRED=[ecosystem_name]
 Start deploying requested GAIA simulation software ecosystem on current host. A set of feature to enable should be specified.
 
=item -e B<name>, --enable-feature=B<name>
 
 Argument : REQUIRED=[feature_name1, feature_name2, ...] | MULTITOKEN
 A comma separated list of target related feature to enable during deployment. A targeted ecosystem should be specified.

=item -h, --help
 
Print a brief help message and exits.
 
=item --man
 
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

Without user-specified option, B<gaia> will print current installed simulation software ecosystem & exit. If any option is provided, then the corresponding comportment described previously will occur.

=head1 COPYRIGHT

Copyright (C) 2015-2017 Nawfel KINANI              
This program comes with ABSOLUTELY NO WARRANTY This is free software, and you are welcome to redistribute under certain conditions
 
=cut
