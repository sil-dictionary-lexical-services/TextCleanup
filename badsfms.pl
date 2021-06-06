#!/usr/bin/env perl
my $USAGE = "Usage: $0 [file.sfm]";
=pod
This script finds all lines that start with an SFM with a missing backslash
It passes over the file to make a list of SFMs
It outputs to STDOUT the list of SFMS (with a trailing backslash)
It passes over the file again and outputs toSTDOUT the line number lines that start with a SFM with no backslash.
Here's a sample listing of a test file
> $ grep -n '.' /tmp/x.tmp # input file with line numbering
> 1:\_sh Shoebox line
> 2:\lxx extra x
> 3:\lx aj
> 4:\lx am
> 5:lz a bad sfm that occurs before the first occurence of its SFM
> 6:\ly ak
> 7:\lz al
> 8:lx this is a line with a bad sfm
> 9:\lw
> 10:lw a bad line
> 11:\lx an
> 12:lo and behold, a line with no SFM but it's not bad
> 13:\lz ao
> 14:\ly ap
> 15:ly another line with a bad SFM
And here's a sample run:
> $ ./badsfms.pl /tmp/x.tmp
> List of Markers:\_sh\lxx\lx\ly\lz\lw
> 5:lz a bad sfm that occurs before the first occurence of its SFM
> 8:lx this is a line with a bad sfm
> 10:lw a bad line
> 15:ly another line with a bad SFM
=cut
use 5.020;
use utf8;

use strict;
use warnings;
use English;
use Data::Dumper qw(Dumper);
my @lines=<>;
my $sfmlist =""; # concatenation of sfm markers
for my $line (@lines) {
	$line =~ s/\R//g; # chomp that works for both lf & crlf
	if ($line =~ m/^\\[^ ]+/) {
		my $sfm=$MATCH;
		$sfmlist .= $sfm if !($sfmlist =~ m/\Q$sfm\E(\\|$)/);
		}
	}

say "List of Markers:$sfmlist";
$sfmlist .= "\\";
my $linecount = 1;
for my $line (@lines) {
	if (!($line =~ m/^\\/) && !($line =~ m/^$/)) {
		(my $badsfm) = split / /, $line;
		say "$linecount:$line" if $sfmlist =~ m/\\\Q$badsfm\E\\/;
		}
	$linecount++;
	}


