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
use 5.024;

# force declaration, warnings & print error diagnostics
use strict;
use warnings;
use diagnostics -verbose;

# libraries
use Getopt::Long qw(GetOptions);    # avoid name-space pollution
use Pod::Usage qw(pod2usage);		# usage pretty print
use Term::ANSIColor qw(:constants); # colored output for the terminal
use FindBin qw($RealBin);   		# facilities
use File::Spec;                     # File Op
use Switch;                         # Switch statement handling
use Time::HiRes qw(time);			# High-resolution timer
use Data::Dumper;					# Dump functionality
use Env;							# Environment variables manipulation

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

# flags
my( 
	$arg_help_flag, 
	$arg_man_flag, 
	$arg_available_flag, 
	$arg_detail_flag
);

# root
my $var_gaia_root = function_CleanPath($FindBin::RealBin."/../..");
	
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
	
	say( BRIGHT_CYAN, "{".time()."} : ", BOLD, MAGENTA, "[GAIA] -- DEBUG : ", RESET, GREEN, shift."() : ", RESET, @_ ) if has_Debug();   
	return; 

} # log_Debug()

sub log_Info    { 
	
	if( has_Debug() ) {
		
		say( BRIGHT_CYAN, "{".time()."} : ", BOLD, BLUE, "[GAIA] -- INFO : ", RESET, GREEN, shift."() : ", RESET, @_ ) if has_Info(); 
	
	} else {
		
		shift;
		say( BOLD, BLUE, "[GAIA] -- INFO : ", RESET, @_ ) if has_Info();
	
	} # if()
	
	return;
	
} # log_Info()

sub log_Warning { 
	
	if( has_Debug() ) {
		
		say( BRIGHT_CYAN, "{".time()."} : ", BOLD, YELLOW, "[GAIA] -- WARNING : ", RESET, GREEN, shift."() : ", RESET, @_ ) if has_Warning(); 
		
	} else {
		
		shift;
		say( BOLD, YELLOW, "[GAIA] -- WARNING : ", RESET, @_ ) if has_Warning();
		
	} # if()
	
	return;
	
} # log_Warning()

sub log_Error   { 
	
	if( has_Debug() ) {
		
		say( BRIGHT_CYAN, "{".time()."} : ", BOLD, RED, "[GAIA] -- ERROR : ", RESET, GREEN, shift."() : ", RESET, @_ ) if has_Error();    
		
	} else {
		
		shift;
		say( BOLD, RED, "[GAIA] -- ERROR : ", RESET, @_ ) if has_Error();
   
	} # if()
	
	# exit
	exit GAIA_EXIT_ERROR;
	
} # log_Error()

# argument verbosity handler
sub log_VerbosityHandler {
	
	# parse
	my ($arg_verbosity_name, $arg_verbosity_value) = @_;
	
	# select
	switch($arg_verbosity_value) {                                                                                                                                                         
		
		case "none" {
			$gaia_verbosity_level = GAIA_VERBOSITY_NONE;
		}
		
		case "error" {
			$gaia_verbosity_level = GAIA_VERBOSITY_ERROR;
		}
		
		case "warning" {
			$gaia_verbosity_level = GAIA_VERBOSITY_WARNING;
		}
		
		case "info" {
			$gaia_verbosity_level = GAIA_VERBOSITY_INFO;
		}
		
		case "debug" {
			$gaia_verbosity_level = GAIA_VERBOSITY_DEBUG;
		}
		
		else {
			
			# log
			log_Warning("log_VerbosityHandler","user-specified verbosity level incorectly parsed, set to default [info] verbosity value. Authorized values are [none, error, warn, info, debug]");

		}
		                                                                                                                                                                 
	} # switch()
        
} # VerbosityHandler()

#-----------------------------------------------------------------------------
# Command line
#
sub function_ParseCmdLine {
	
	# define arguments
    Getopt::Long::GetOptions(

        'help|h'        =>  \$arg_help_flag,
        'man'           =>  \$arg_man_flag,
        'available|a'   =>  \$arg_available_flag,
        'detail|d'      =>  \$arg_detail_flag,
        'verbosity|v=s' =>  \&log_VerbosityHandler

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
    		
    		# get only the first feature name (normally, there should be onlye one...)
    		my ($feature_name, $feature_check) = $feature_filename =~ /third_party-(.*?)\.feature/g;
    		if( defined($feature_check) ) {
    			    		
    			log_Warning("function_ParseAllAvailableEcosystem","multiple token found during regex extraction... [".$feature_filename."] for feature [".$feature_name."] --> found [".$feature_check."]");
    		 
    		} # if()
    		
    		log_Debug("function_ParseAllAvailableEcosystem","inspecting [".$sub_ecosystem_root."/".$feature_filename."] for feature [".$feature_name."]");
    		 
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
    		for my $priority_index (0 .. $#third_party_file_array) {
    			
    			log_Debug("function_ParseAllAvailableEcosystem","spliting row -> [".$third_party_file_array[$priority_index]."]");
    			
    			# split thritd party row
    			my ($third_party_name, $third_party_version) = split( / /, $third_party_file_array[$priority_index] ); # split on space
    			my ($third_party_major, $third_party_minor, $third_party_patch) = split( /\./, $third_party_version ); # split on dot
    			
    			log_Debug(
    				"function_ParseAllAvailableEcosystem",
    				"found priority -> [".($priority_index + 1)."] name -> [".$third_party_name."] version -> [".$third_party_version."] major -> [".$third_party_major."] minor -> [".$third_party_minor."] patch -> [".$third_party_patch."]"
    			);
    			
    			push @third_party_array, {
    				
    				Name     => $third_party_name,
					Priority => ( $#third_party_file_array - $priority_index ),
					Major    => $third_party_major,
					Minor    => $third_party_minor,
					Patch    => $third_party_patch
    				
    			};
    			    
			} # for()
    		
    		push @feature_array, {
    				
    			Name        => $feature_name,
				Third_party => [ @third_party_array ]
    				
    		};
    		
    	} # foreach()
    	
		push @ecosystem_array, {
    				
    		Name    => $ecosystem_name,
    		Detail  => $sub_ecosystem_detail_filename,
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
    
    
    
    log_Debug("function_DumpAvailableEcosystemDetail","<===== exit point");
    
} # function_DumpAvailableEcosystemDetail()

#-----------------------------------------------------------------------------
# Main
#
MAIN:
{	
	
	# first of all, parse command line
	function_ParseCmdLine();
	
	# log
	log_Debug("Main","found RealBin=[".$FindBin::RealBin);
	log_Debug("Main","found GAIA root directory -> [".$var_gaia_root."]");
	
	# if not any flag
	if( !$arg_available_flag ) {
		
		# just output the current ecosystem detail
   		log_Debug("Main","begining dumping distribution detail operation");
		function_DumpCurrentEcosystemDetail();
		
	} else {
		
		# parse
	    log_Debug("Main","begining parsing operation");
		function_ParseAllAvailableEcosystem();
	
		# dump
	    log_Debug("Main","begining dumping internal datamodel operation");
		function_DumpInternalDatamodel();
		
		# otherwise, print available ecosystem
	    log_Debug("Main","begining dumping available ecosystem operation");
		function_DumpAvailableEcosystemDetail();
		
	} #if()
	
	# success
    log_Debug("Main","Successfully completed all operation. Exiting...");
    exit(GAIA_EXIT_SUCCESS);

} # MAIN

# end 
__END__

=head1 NAME
 
GAIA : required LABSIM ground software ecosystem                  
 
=head1 SYNOPSIS
 
gaia-ecosystem [options]
 
 Options:
   --verbosity|v  current script verbosity
   --available|a  list all available simulation software ecosystem
   --detail|d     detailled output
   --help|h       brief help message			
   --man          full documentation
   
=head1 OPTIONS
 
=over 4

=item B<-v, --verbosity> I<[DEFAULT=B<info>]> I<[OPTIONAL]>

Currrent level of verbosity. Available level are [none, error, warn, info, debug]

=item B<-a, --available> I<[OPTIONAL]>

List all available simulation software ecosystem listed under the $ENV{GAIA_ROOT}/ecosystem/ directory. Print output & exit.

=item B<-d, --detail> I<[OPTIONAL]>

Print detailled output.

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

By default, B<gaia-ecosystem> will print current installed simulation software ecosystem & exit. If any option is provided, then the corresponding comportment described previously will occur.

=head1 COPYRIGHT

Copyright (C) 2015-2017 Nawfel KINANI              
This program comes with ABSOLUTELY NO WARRANTY This is free software, and you are welcome to redistribute under certain conditions
 
=cut
