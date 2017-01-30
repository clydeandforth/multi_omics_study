#!/usr/bin/perl
#by_James_Doonan


use strict;
use warnings;

my $file = 'BG59_uniprot.txt';
open my $infile, '<', $file or die "Cannot open file: $!";

my (@group1, @group2, @group3, @group4,	@group5, @group6, @group7, @group8, @group9, @group10, @group11, @group12, @group13, @group14, @group15);

while(<$infile>) {
	next if /^\s*#/;
	s/#.*$//;
	my @split = split('\t');
	push @group1, $split[0];
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
	push @group12, $split[11];
	push @group13, $split[12];
	push @group14, $split[13];
	push @group15, $split[14];
	#print the line if there are more than 3 transcripts hitting one gene and it covers more than 20% of the gene
        print if ($split[10]  >= 3 && $split[14] >= 0.2);
       
}


close($infile);

