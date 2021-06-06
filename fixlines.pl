#!/usr/bin/env perl
my $USAGE = "Usage: $0 [--fixlist fixlines.lst] [infile.sfm]";
=pod
This script reads a file of line numbers that need to be "fixed".
It applies a change to each of those line.
The change to be applied is inside the subroutine named "fixline"
=cut
use 5.020;
use utf8;

use strict;
use warnings;
use English;
use Data::Dumper qw(Dumper);

# code to apply to lines that need to be fixed
sub fixline {
my ($line) = @_;
#
# change the following line to make the change to the selected lines
#
$line =~ s/^/\\/;
#
return ($line);
}

use Getopt::Long;
GetOptions (
	'fixlist:s'   => \(my $linenumbersfilename = "fixlines.lst"), # fixlist filename
	'debug'       => \my $debug,
	) or die $USAGE;

my %fixnumbershash;
open(my $lnfh, "<", $linenumbersfilename)
    or die "Failed to open file with line numbers: $!\n";
while(<$lnfh>) { 
	s/\R*$//; # chomp that works for both lf & crlf
	next if !(m/^( )*?([0-9]+)/); # Line number must be at the beginning of the file
	$fixnumbershash{$2} = "1";
	} 
close $lnfh;
print Dumper \%fixnumbershash;

my $linecount = 1;
while (<>) {
	s/\R*$//; # chomp that doesn't care about Linux & Windows
	$_ = fixline($_) if exists $fixnumbershash{$linecount};
	$linecount++;
	say $_;
	}
