#!/bin/bash

# directory
dir="/Volumes/Expansion/Bulk_RNAseq_Run/FASTQ_Trimmed"
outdir="/Volumes/Expansion/Bulk_RNAseq_Run/MappingResults"
indexdir="/Volumes/Expansion/HISAT2_index/grcm38_snp_tran/genome_snp_tran"

mkdir $outdir

# go to FASTQ_trimmed directory
cd $dir

# declare an array variable
declare -a R1=(*_R1_001_val_1.fq.gz)
declare -a R2=(*_R2_001_val_2.fq.gz)
IFS=" " read -r -a samples <<< "$(echo "${R1[@]//_*/}" | tr ' ' '\n' | sort -u | tr '\n' ' ')"
declare -a Output=($(echo "${R1[@]}" | sed "s/_R1_001_val_1.fq.gz//g"))

len=${#samples[@]}

# mapping and indexing
for ((i=0; i<$len; i++)); do
mkdir $outdir/"${samples[$i]}"
declare -a R1input=(${samples[$i]}*_1.fq.gz)
declare -a R2input=(${samples[$i]}*_2.fq.gz)
R1inputfiles=($(echo "${R1input[@]}" | sed "s/ /,/g"))
R2inputfiles=($(echo "${R2input[@]}" | sed "s/ /,/g"))
output=($(echo "${samples[$i]}" | sed "s/$/.sam/g"))
hisat2 -p 6 --rna-strandness RF -x $indexdir -1 $R1inputfiles -2 $R2inputfiles -S "$outdir"/"${samples[$i]}"/"$output"
cd  $outdir/"${samples[$i]}"
sam=$(echo "${samples[$i]}.sam")
bam=$(echo "${samples[$i]}.bam")
sortedbam=$(echo "${samples[$i]}_sorted.bam")
samtools view -bS $sam > $bam
samtools sort $bam -o $sortedbam
samtools index $sortedbam
cd $dir
done
