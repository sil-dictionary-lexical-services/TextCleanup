#!/usr/bin/perl

# Usage: dos2unix.pl < infile > outfle

# Change DOS line ends to Unix ones.
# Can be used as a "filter" in a sequence of command line commands.

# Only works with Perl in a Unix system.
# Perl as distributed with git and Strawberry Perl on Windows 
# add CR-LF anyway.

# Created:	23 Feb 2018	bb
# Modified:	13 Feb 2020	bb	Add comments

while (<>) {
	$_ =~ s/\r\n/\n/g;
	print $_;
	}
