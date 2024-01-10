#!/bin/bash

# directory
dir="/Volumes/Expansion/Bulk_RNAseq_Run/FASTQ_trimmed"

# go to the directory
cd $dir

# rename files
rename -e 's/LIBxxxxx_//' *.fq.gz
rename -e 's/LIBxxxxx_//' *.txt
