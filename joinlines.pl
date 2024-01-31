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

# Modified:	31 Jan 2024		bb	Allow blank lines to have spaces on them.
#															Handle non-SFM lines after a blank line: Report Error
# Modified:	07 Jun 2023		bb	Improve line end handling, remove trailing blanks,
#													   add more comments
# Modified:	13 Feb 2020	bb	Add comments
# Created:	  8 Mar 2004	bb

# Line number in original file
$linecount = 0;

# Count how many lines were joined, for verification.
$i = 0;

# Read in first line
$prevline = <>;
# Strip off line end and trailing blanks
chomp $prevline;
$prevline =~ s/ +$//;
$linecount++;

# Check beginning of each successive line, and join with previous if not a new SFM
while ($curline = <>) {
	# Strip off line end and trailing blanks
	chomp $curline;
	$linecount++;
	$curline =~ s/ +$//;
	#print STDERR "Testing [$curline]\n";
	
	## Test for the kind of line; do different actions depending on results
	# Empty line
	if ($curline =~ /^ *$/) { # indicates end of SFM record or field
		print "$prevline\n";
		$prevline = $curline;		
		}
	# Does not start with backslash
	elsif ($curline !~ /^\\/) { # continuation of an SFM; join it, adding a space in between
		# Report error if previous line was blank
		if ($prevline =~ /^ *$/) {
			print STDERR "ERROR: non-SFM line occurred after a blank line, ";
			print STDERR "at line $linecount [$curline]\n";
			print STDERR "Remove blank lines within fields in file and run this script again.\n\n";
			}
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

