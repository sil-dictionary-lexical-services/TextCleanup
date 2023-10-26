#!/usr/bin/perl

# Usage: joinlines.pl < infile > outfile

# Assumes an SFM file, with backslash codes marking the fields.
# Assumes Unix line endings.
# Finds any fields that span multiple lines and puts them onto a single line.

# First strips trailing spaces from each line.
# Replaces the linebreak with a space.
# Reports to the terminal how many lines were joined.

# In the future, could be modified to:
# - make sure there are no blank lines in the middle of records.
# - make sure the file ends with a blank line.

# Modified:	07 Jun 2023		bb	Improve line end handling, remove trailing blanks,
#													   add more comments
# Modified:	13 Feb 2020	bb	Add comments
# Created:	  8 Mar 2004	bb

# Count how many lines were joined, for verification.
$i = 0;

# Read in first line
$prevline = <>;
# Strip off line end and trailing blanks
chomp $prevline;
$prevline =~ s/ +$//;

# Check beginning of each successive line, and join with previous if not a new SFM
while ($curline = <>) {
	# Strip off line end and trailing blanks
	chomp $prevline;
	$prevline =~ s/ +$//;
	
	## Test for the kind of line; do different actions depending on results
	# Empty line
	if ($curline =~ /^$/) { # indicates end of SFM record or field
		print "$prevline\n";
		$prevline = $curline;		
		}
	# Does not start with backslash
	elsif ($curline !~ /^\\/) { # continuation of an SFM; join it, adding a space in between
		$prevline = $prevline . " " . $curline;
		# Increment the count of how many lines have been joined
		$i++;
		}
	# Starts with backslash
	else { # new SFM; print whatever has accumulated in previous line and start over
		print "$prevline\n";
		$prevline = $curline;
		}
	}
# Print the final line.
print "$prevline\n";

# Report
print STDERR "$i lines were combined with the previous one.\n";

