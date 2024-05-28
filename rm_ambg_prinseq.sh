#!/bin/usr/env bash

#
# bash rm_ambg_prinseq.sh [directory containing sequences] 
#
# This script will download prinseq lite version 0.20.4 and run the perl script to remove abiguous basecalls 
# written by Jeffrey Brown (brown.jeffrey.dean@gmail.com)
# last update 05-28-2024


curl -LO https://raw.githubusercontent.com/uwb-linux/prinseq/master/prinseq-lite.pl
dir=$(dirname $1)
base=$(basename $1)
cleardir=${dir}/clear_$base
ambigdir=${dir}/ambig_$base
outfile="${cleardir}/prinseq_log.txt"

mkdir $cleardir
mkdir $ambigdir

for f in $1*;
do perl prinseq-lite.pl -verbose -fastq $f -ns_max_n 0 -out_good ${cleardir}/clr_$(basename ${f%.fastq}) -out_bad ${ambigdir}/amb_$(basename ${f%.fastq}) -log $outfile 
done
echo -e "\n\nDone! Your cleared sequences are stored in $cleardir and your ambiguous sequences are stored in $ambigdir. $outfile has the information about your data.\n\n"

rm prinseq-lite.pl
