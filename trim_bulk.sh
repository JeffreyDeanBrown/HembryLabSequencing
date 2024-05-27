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

mkdir trimd_$1

for f in $1* ;
do echo -e "------------------------------\n$(basename $f)";
fastq_quality_trimmer -Q 33 -t 20 -l 130 -i $f -o data_trimmed/trim_$(basename $f) -v;
done | tee trimd_$1Trim_Statistics.txt

#awk script to add all of the stats together into an overall statistics page
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
' trimd_$1Trim_Statistics.txt | cat - trimd_$1Trim_Statistics.txt > temp
mv temp trimd_$1Trim_Statistics.txt

echo "\n\nDone! All trimmed sequences are in trimd_$1 and all of the statistics for the trim are saved in trimed_$1Trim_Statistics.txt \n\n"
