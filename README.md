# TextCleanup
Scripts for prepping SFM files for the analysis phase of migrating to FLEx

+ dos2unix.pl - converts Windows line ends to Unix line ends (command line filter)
+ joinlines.pl - unwraps lines in a SFM file, so each field is on only one line
+ badsfms.pl - finds SFMs that are missing a backslash; prints them with their line number
+ fixlines.pl - apply a change to all line numbers; default change is to add a leading backslash
