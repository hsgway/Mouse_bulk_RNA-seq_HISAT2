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
declare -a R1=(*_R1_001.fastq.gz)
declare -a R2=(*_R2_001.fastq.gz)

# length of the array (number of files)
len=${#R1[@]}

# execute TrimGalore
for ((i=0; i<$len; i++)); do
trim_galore --cores 3 --paired --gzip -o "$outdir" "${R1[$i]}" "${R2[$i]}"
done

# deactivate the environment
conda deactivate
