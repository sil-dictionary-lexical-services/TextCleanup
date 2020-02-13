#!/usr/bin/perl

# Usage: joinlines.pl < infile > outfile

# Assumes an SFM file, with backslash codes marking the fields.
# Finds any fields that span multiple lines and puts them onto a single line.
# Replaces the linebreak with a space.
# Reports to the terminal how many lines were joined.

# Doesn't do other consistency checking that is needed.
# In the future, could be modified to:
# - make sure there are no blank lines in the middle of records.
# - make sure the file ends with a blank line.

# Created:	8 Mar 2004	bb
# Modified:	13 Feb 2020	bb	Add comments

# Count how many lines were joined, for verification.
$i = 0;

# Read in first line
$prevline = <>;

# Check beginning of each successive line, and join with previous if not a new SFM
while ($curline = <>) {
	if ($curline =~ /^$/) { # end of record
		print $prevline;
		$prevline = $curline;		
		}
	elsif ($curline !~ /^\\/) { # continuation of an SFM; join it
		chop($prevline);
		$prevline = $prevline . " " . $curline;
		$i++;
		}
	else { # new SFM; print previous line
		print $prevline;
		$prevline = $curline;
		}
	}
# Print the final line.
print $prevline;
# For good measure, put a blank line at the end.
print "\n";

print STDERR "$i lines were combined with the previous one.\n";

