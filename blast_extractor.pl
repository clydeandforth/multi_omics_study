#!/usr/bin/perl
#by_James_Doonan
#blast_extractor

package Fasta;
use strict;
use warnings;


my $file = 'Gq13_uniref50';

open my $infile, '<', $file or die "Cannot open file: $!";

my (@group1, @group2, @group3, @group4, @group5, @group6, @group7, @group8, @group9, @group10, @group11);

while(<$infile>) {
	chomp;
	# skip lines starting with #
        next if /^\s*#/;
        s/#.*$//;
	#change space to tab delimiter
	$_  =~ s/\s+/\t/g;
        # put each tab delimited column into an array
#	next if (/\^START\b/ .. /^START\b/);
	my @split = split('\t');
	
        push @group1, $split[0]; #{next if (/\^START\b/ .. /^START\b/)}
	push @group2, $split[1];
        push @group3, $split[2];
        push @group4, $split[3];
        push @group5, $split[4];
        push @group6, $split[5];
        push @group7, $split[6];
        push @group8, $split[7];
        push @group9, $split[8];
        push @group10, $split[9];
        push @group11, $split[10];
        #print columns 1,2,4 and add a tab between each, add newline at the end
	next if (/\^START\b/ .. /^START\b/);
        print join ("\t", $split[0], $split[1], $split[3]) . "\n";

	
}


close($infile);


