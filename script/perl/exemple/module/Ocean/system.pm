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
package Ocean::system;

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
	    ExecutablePrefix
	    NetworkInterfaceAddress
	    WriteCache
	    ReadCache
	    CountToken
	    ExtractToken
	    FindAndReplaceToken
	    CleanPath
	    Filename
	    Fileext
	    Filepath
	    RemoveDirectory
	    MakeDirectory
	    CopyDirectory
	    CopyDirectoryIfExist
	    CheckDirectory
	    CopyFileFromGlob
	    CopyFile
	    CopyFileIfExist
	    RemoveFile
	    CheckFile
	    ParseCommandLineOptions
	    Trim
	    TrimAndLowercase
	    TrimAnsUppercase
    );
    
}

# RHEA Packages
use lib qw(../../module);
use Ocean::var;
use Ocean::default;
use Ocean::help;

# option handling & file module
use Getopt::Long qw(GetOptions);
Getopt::Long::Configure qw(gnu_getopt);
use Pod::Usage qw(pod2usage);
use Pod::Find qw(pod_where);
use File::Path;
use File::Copy;
use File::Spec;
use File::Copy::Recursive;
use File::Remove;
use File::Basename;
use Net::Address::IP::Local;
use FindBin qw($Bin $Script);

# ------------------------------------
# OCEAN System package
# ------------------------------------
#
# Ce fichier contient l'ensemble des routines de faisant appel aux fonctions systemes
#
# author : 	Nawfel Kinani
# creation: 16/07/12
# group : 	Onera DCSD/PSEV LabSim
#

###
# Get the depending executable prefix
sub ExecutablePrefix {
	
	# Whatever if it's a windows OS machine 
	if($^O eq 'MSWin32') {
		return ".exe";
	}
	# else no prefix
	return "";

} # ExecutablePrefix()

###
# Get the depending executable prefix
sub NetworkInterfaceAddress {
	
	# return the address connected to dcsd-simbridge on private network
	return Net::Address::IP::Local->connected_to('192.168.41.254');

} # NetworkInterfaceAddress()

###
# Write a cached file for piping purpose only : return filename
sub WriteCache {
	
	open my $fh, '>', "tmp.pl" or die "Could not open file: $!";
	print $fh @_;
	undef $fh;
	return "tmp.pl";
	
} # WriteCache()

###
# Read a cached file for piping purpose only : return filename / file handle
sub ReadCache {
	
	open my $fh, '<', "tmp.pl" or die "Could not open file: $!";
	return ( "tmp.pl", $fh );
	
} # ReadCache()

###
# Count tokens occurence in a specified file
sub CountToken {
	
	my ( $filename, $pattern ) = @_;
	open my $fh, '<', $filename or die "Could not open file: $!";
	return scalar( grep { m|$pattern|g } <$fh> );
	
} # CountToken()

###
# Extract tokens occurence in a specified file
sub ExtractToken {
	
	my @tabPtr;
	my ( $filename, $pattern ) = @_;
	open my $fh, '<', $filename or die "Could not open file: $!";
	foreach my $line ( grep { m|$pattern|g } <$fh> ) {
		push( @tabPtr, $line );
	}
	return @tabPtr;
	
} # ExtractToken()

###
# Extract tokens occurence in a specified file
sub FindAndReplaceToken {

	# variables
	my ( $filename, $token, $replacement ) = @_;

	open( FILE, "<$filename" ) || die "File not found";
	my @lines = <FILE>;
	close(FILE);

	my @newlines;
	foreach (@lines) {	
		$_ =~ s/$token/$replacement/g;
		push(@newlines, $_ );
	}

	open( FILE, ">$filename" ) || die "File not found";
	print FILE @newlines;
	close(FILE);
	
} # FindAndReplaceToken()
 
###
# Subroutines de nettoyage d'un path relatif etc etc
sub CleanPath {

	# clean path relatively to the current binary dir, unwind it & return the result
	# cf [ http://www.perlmonks.org/?node_id=362731 ]
	
	my $raw = shift;
    my( $volume, $directories, $file ) = File::Spec->splitpath( File::Spec->canonpath( File::Spec->rel2abs( $raw, $FindBin::Bin ) ) );
    my( @dur ) = File::Spec->splitdir( $directories );
    my @dar;
    
    foreach(@dur){
        if( $_ eq File::Spec->updir() ){
            pop @dar;
        } else {
            push @dar, $_;
        }
    }

    my $clean = File::Spec->catpath(
        $volume,
        File::Spec->catdir( @dar ),
        $file
    );
    
	print "\t[clean path] from : ".$raw." to ".$clean."\n"; 
	return $clean;
	
} # CleanPath()

###
# Subroutines d'extraction du filename depuis un path complet
sub Filename {
	
	# split & return
	my($file, $path, $ext) = fileparse( shift , qr/\.[^.]*/);
	return $file;

} # Filename()

###
# Subroutines d'extraction du fileext depuis un path complet
sub Fileext {
	
	# split & return
	my($file, $path, $ext) = fileparse( shift , qr/\.[^.]*/ );
	return $ext;

} # Fileext()

###
# Subroutines d'extraction du fileext depuis un path complet
sub Filepath {
	
	# split & return
	my($file, $path, $ext) = fileparse( shift , qr/\.[^.]*/);
	return $path;

} # Filepath()

###
# Subroutines de suppression du repertoire en argument --> rm -rf
sub RemoveDirectory {

	# On efface les fichiers si present
	if ( -d $_[0] ) {

		File::Path::remove_tree( $_[0], { verbose => 0, error => \my $err, result => \my $rslt } );

		# si erreur
		if (@$err) {

			# unpack error list
			for my $diag (@$err) {
				my ( $file, $msg ) = %$diag;

				# & print error message depending on kind of error
				if ( $file eq '' ) {
					print "\t[remove dir] general error: $msg\n";
				}
				else {
					print "\t[remove dir] problem unlinking $file: $msg\n";
				}
			}

		}
		else {

			# print status
			print "\t[remove dir] no error encountered : unlinked dir $_[0] \n";
		}
	}
	
} # RemoveDirectory()

###
# Subroutines de creation du repertoire en argument --> mkdir -p
sub MakeDirectory {

	# On cree si non present
	if ( not -d $_[0] ) {

		File::Path::make_path( $_[0], { verbose => 0, error => \my $err } );

		# si erreur
		if (@$err) {

			# unpack error list
			for my $diag (@$err) {
				my ( $file, $msg ) = %$diag;

				# & print error message depending on kind of error
				if ( $file eq '' ) {
					print "\t[make dir] general error: $msg\n";
				}
				else {
					print "\t[make dir] problem linking $file: $msg\n";
				}
			}

		}
		else {

			# print status
			print "\t[make dir] no error encountered : linked dir $_[0] \n";
		}
	}
	
} # MakeDirectory()

###
# Subroutines de copie de deux fichiers en argument --> cp -r
sub CopyDirectory {

	# get argument
	my ( $src, $tgt ) = @_;

  	# Relay on recursive properties of embedded CPAN  File::Copy::Recursive Module
	File::Copy::Recursive::rcopy( $src, $tgt ) or die "\t[copy dir] directory copy failed: $!\n";

	# status
	print "\t[copy dir] no error encountered : copied directory contents from $src to $tgt\n";
	  
} # CopyDirectory()

###
# Subroutines de copie de deux fichiers en argument --> cp -r
sub CopyDirectoryIfExist {

	# get argument
	my ( $src, $tgt ) = @_;

	# only if dosn't exist
	if ( not -d $src ) {

		# status
		print "\t[copy dir] try copied directory from $src but not found, skip... \n";
		return;
	}

	# follow call
	CopyDirectory( $src, $tgt );
	
} # CopyDirectoryIfExist()

###
# Teste l'existance d'une liste de directory passé en arguments
sub CheckDirectory {
	
	# On boucle sur chaucun de nos arguments et on teste
	for my $dir(@_) {
		
		print "\t[check dir] $dir ";
		if(not -d $dir) {
			print "fail !\n";
			die("subroutines Ocean::system::CheckDirectory() failed ! exit...");
		} 
		print "success !\n";
	}
	
} # CheckDirectory()

###
# Subroutines de copie des fichiers correspondant au pattern en argument --> cp -n ------> crash on error
sub CopyFileFromGlob {

	# get argument
	my ( $glob, $tgt ) = @_;

  	# Relay on recursive properties of embedded CPAN  File::Copy::Recursive Module
	File::Copy::Recursive::rcopy_glob($glob, $tgt) or die "\t[copy file] copy failed: $!\n";

	# status
	print "\t[copy file] no error encountered : copied file from from pattern $glob to $tgt\n";
	
} # CopyFileFromGlob()

###
# Subroutines de copie de deux fichiers en argument --> cp -n ------> crash on error
sub CopyFile {

	# get argument
	my ( $src, $tgt ) = @_;

  	# Relay on recursive properties of embedded CPAN  File::Copy::Recursive Module
	File::Copy::Recursive::fcopy( $src, $tgt ) or die "\t[copy file] copy failed: $!\n";

	# status
	print "\t[copy file] no error encountered : copied file from $src to $tgt\n";
	
} # CopyFile()

###
# Subroutines de copie de deux fichiers en argument --> cp -n ------> copy only if it exist
sub CopyFileIfExist {

	# get argument
	my ( $src, $tgt ) = @_;

	# only if dosn't exist
	if ( not -e $src ) {

		# status
		print "\t[copy file] try copied file from $src but not found, skip... \n";
		return;
	}

	# follow call
	CopyFile( $src, $tgt );
	
} # CopyFileIfExist()

###
# Subroutines de copie de suppresion des fichiers en argument --> cp -n ------> crash on error
sub RemoveFile {

	# get argument
	my (@files) = @_;

  	# Relay on recursive properties of embedded CPAN  File::Copy::Recursive Module
	File::Remove::remove(@files) or die "\t[remove file] removing failed: $!\n";

	# status
	print "\t[remove file] no error encountered : unlinked file(s) from".join(" ",@files)."\n";
	
} # RemoveFile()

###
# Teste l'exitence d'une liste de fichier régulier particulier passé en paramètre
sub CheckFile {
	
	# On boucle sur chaucun de nos arguments et on teste
	for my $file(@_) {
		
		print "\t[check file] $file ";
		if(not -e $file) {
			print "fail !\n";
			die("subroutines Ocean::system::CheckFile() failed ! exit...");
		} 
		print "success !\n";
	}
	
} # CheckFile()
###
# Fonction de lecture de la ligne d'arguments
sub ParseCommandLineOptions {
	
	# arguments - empty
	my (
		$arg_experiment_directory,
		$arg_project_directory,
		$arg_debug_flag,
		$arg_dump_flag,
		$arg_help_flag,
		$arg_man_flag
	);
	    
	## Parse options and print usage if there is a syntax error,
	## or if usage was explicitly requested.
	GetOptions(
		'experiment-dir|e=s' 	=> \$arg_experiment_directory,
		'project-dir|p=s' 		=> \$arg_project_directory,
	    'debug!'				=> \$arg_debug_flag,
	    'dump!'					=> \$arg_dump_flag,
		'help|h'				=> \$arg_help_flag,
	    'man'					=> \$arg_man_flag
	) or pod2usage( { -input => pod_where( { -inc => 1 }, "Ocean::help"), -exitval => 1 } );
	pod2usage( { -input => pod_where( { -inc => 1 }, "Ocean::help"), -verbose => 1, -exitval => 0 } ) if $arg_help_flag;
	pod2usage( { -input => pod_where( { -inc => 1 }, "Ocean::help"), -verbose => 2, -exitval => 0 } ) if $arg_man_flag;
 
	# If no arguments were given, print usage
	pod2usage( { -input => pod_where( { -inc => 1 }, "Ocean::help"), -exitval => 1, -message => "$0: No experiment directory given." } )  if !$arg_experiment_directory;
	pod2usage( { -input => pod_where( { -inc => 1 }, "Ocean::help"), -exitval => 1, -message => "$0: No project directory given." } )  if !$arg_project_directory;
	
	# options
	$Ocean::var::g__debug_flag = $arg_debug_flag;
	$Ocean::var::g__dump_flag = $arg_dump_flag;
	$Ocean::var::g__custom_experiment_dir = $arg_experiment_directory;
	$Ocean::var::g__custom_project_dir = $arg_project_directory;
	
} # ParseCommandLineOptions()

sub Trim { my $s = shift; $s =~ s/^\s+|\s+$//g; return $s };
sub TrimAndLowercase { my $s = shift; $s =~ s/^\s+|\s+$//g; return lc($s) };
sub TrimAndUppercase { my $s = shift; $s =~ s/^\s+|\s+$//g; return uc($s) };

# end module
1;
__END__
