#!/usr/bin/env bash
#
# 
# pearing.sh [directory containing reads]
#
# This script will separate illumina sequences into R1 and R2 reads, then merged the R1 and R2 samples one at a time using PEAR
# written by Jeff Brown (brown.jeffrey.dean@gmail.com)
# last updated 05-27-2024
#
#
mkdir $1sequences_R1/
mkdir $1sequences_R2/
mkdir $1unassembled_PEAR/
mkdir $1Merged_PEAR/
mv $1*R1_* $1sequences_R1/
mv $1*R2_* $1sequences_R2/

for f in $1sequences_R1/*;
 do
 #name the files being merged
	echo $f;
	echo $1sequences_R2/$(basename $f | head -c-13)*;
 #merge the files (pear -f forward/read.fastq -r reverse/read.fastq -o output/path/merged_and_unnassembled
	pear -f $f -r $1sequences_R2/$(basename $f | head -c-13)* -o $1unassembled_PEAR/$(basename $f | head -c-13);
done | tee $1Merged_PEAR/merge_$(date +"%d-%b-%Y").txt

mv $1unassembled_PEAR/*.assembled.fastq $1Merged_PEAR/

echo -e "\n\nDone! Your Merged Sequences are in $1Merged_PEAR/ and all of the information on screen was recorded as $1Merged_PEAR/merge_$(date +"%d-%b-%Y").txt\n\n"
