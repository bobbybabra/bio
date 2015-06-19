#!/usr/bin/perl


#########################################################
# fastq2fasta                                           #
#########################################################

use strict;
use warnings;
use Getopt::Std;
use POSIX qw/ ceil floor /;
use vars qw/ $opt_i $opt_o/;

#########################################################
# Start Variable declarations                           #
#########################################################

my ($infile, $outfile);
my $i = 0;

#########################################################
# End Variable declarations                             #
#########################################################

#########################################################
# Start Main body of Program                            #
#########################################################

 &getopts('i:o:');
 &var_check();

 print STDERR "\n\tStarting to process FASTQ file \"$infile\"\n";

 #print STDERR "\n\t\tCounting the number of lines in the file...";
 #my $total_value = `/usr/bin/wc $infile`;
 #$total_value =~ s/\s+/ /g;
 #$total_value =~ s/^ //;
 #my @total_values = split(/ /, $total_value);
 #my $total_lines = $total_values[0];

 #print STDERR "\n\t\t\tTotal Sequences = ".($total_lines / 4)."\n\n";

 open( INFILE, "<", $infile)  or die "Can not open $infile: $!";
 open( OUTFILE, ">", $outfile)  or die "Can not open $outfile: $!";

 while (<INFILE>){

	chomp($_);
	my $line0 = $_;
	chomp(my $line1 = <INFILE>);
	chomp(my $line2 = <INFILE>);
	chomp(my $line3 = <INFILE>);

	if ($line0 =~ m/^\@/){
  		print OUTFILE ">$line0\n";
  		print OUTFILE "$line1\n";
		$i++;
	}
	else {
		print STDERR "\n\t\tThe input file is not in FASTQ format\n\n";
		print STDERR "\tLine 1 = $line0\n";
		print STDERR "\tLine 2 = $line1\n";
		print STDERR "\tLine 3 = $line2\n";
		print STDERR "\tLine 4 = $line3\n";
		print STDERR "\n";
		exit 0;
	}

        #my $percent_left = ($i/$total_lines);
        #my $percent = ceil(($percent_left)*100);
        #$percent .= '%';
        #print STDERR "\t$percent\r";

 }

 close INFILE;
 close OUTFILE;

 print STDERR "\n\tTotal number of sequences processed: $i\n\n";

#########################################################
# Start of Variable Check Subroutine "var_check"        #
# if we came from command line do we have information   #
# and is it the correct info.. if not go to the menu... #
# if we came from the web it should all check out...    #
#########################################################

sub var_check {

  if ($opt_i) {
   $infile = $opt_i;
  } else {
   &var_error();
  }

  if ($opt_o) {
   $outfile = $opt_o;
  } else {
   &var_error();
  }

}

#########################################################
# End of Variable Check Subroutine "var_check"          #
#########################################################

#########################################################
# Start of Variable error Subroutine "var_error"        #
#########################################################
sub var_error {

  print "\n\n";
  print "  You did not provide all the correct command line arguments\n\n";
  print "  Usage:\n";
  print "  fastq2fasta.pl -i <input fastq file> -o <outfile fasta name>\n";
  print "\n\n\n";
  print "  -i   Input data file in FASTQ format.\n";
  print "\n";
  print "  -o   Outfile name.\n";
  print "\n\n\n";
  exit 0;

}

#########################################################
# End of Variable error Subroutine "var_error"          #
#########################################################
