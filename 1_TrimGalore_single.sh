#!/bin/bash

# directory
dir="/Volumes/Expansion/Bulk_RNAseq_Run/FASTQ"
outdir="/Volumes/Expansion/Bulk_RNAseq_Run/FASTQ_trimmed"

mkdir $outdir

# activate the environment
source activate trimgalore

# change directory
cd $dir

# declare an array variable
# change "fastq.gz" to the extension your file names have
# fastq file extension could also be "fq.gz"
declare -a R=(*.fastq.gz)

# length of the array (number of files)
len=${#R[@]}

# execute TrimGalore
for ((i=0; i<$len; i++)); do
  trim_galore --cores 3 --gzip -o "$outdir" "${R[$i]}"
done

# deactivate the environment
conda deactivate
