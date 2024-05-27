#!/usr/bin/env bash
#
#
# trim_script.sh [directory with FASTQ files]
#
# This trims all of the fastq files in a directory and spits out a statistics page with a summary as well as info on every sequence trimmed
# written by Jeff Brown (brown.jeffrey.dean@gmail.com)
# last updated 05-16-2024
#
#
for f in $1* ;
do echo -e "------------------------------\n$(basename $f)";
fastq_quality_trimmer -Q 33 -t 20 -l 130 -i $f -o data_trimmed/trim_$(basename $f) -v;
done > Trim_Statistics.txt
	awk '
BEGIN {
input=(0)
output=(0)
discarded=(0)
print "Statistics for all data:"}
/Input:/ {input=input+$2}
/Output:/ {output=output+$2}
/discarded/ {discarded=discarded+$2}
END {
print "\nInput: "input" reads.\nOutput: "output" reads.\nDiscarded: "discarded" (" (discarded/input)*100"%) too-short reads.\n \nStatistics for each trimmed sample: \n"
}
' Trim_Statistics.txt | cat - Trim_Statistics.txt > temp
mv temp Trim_Statistics.txt
