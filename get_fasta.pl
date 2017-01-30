#!/usr/bin/perl

use strict;
use warnings;


use Bio::DB::Fasta;

#usage infasta.fa queryfile.txt
my $seq;
my $fastaFile = shift;
my $queryFile = shift;

my $db = Bio::DB::Fasta->new( $fastaFile );
open (IN, $queryFile);
while (<IN>){
    chomp; 
    $seq = $_;
    my $sequence = $db->seq($seq);
    if  (!defined( $sequence )) {
            die "Sequence $seq not found. \n" 
    }   
    print ">$seq\n", "$sequence\n";
}
