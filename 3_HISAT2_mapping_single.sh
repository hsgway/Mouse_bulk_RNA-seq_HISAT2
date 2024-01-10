#!/bin/bash

# directory
dir="/Volumes/Expansion/Bulk_RNAseq_Run/FASTQ_Trimmed"
outdir="/Volumes/Expansion/Bulk_RNAseq_Run/MappingResults"
indexdir="/Volumes/Expansion/HISAT2_index/grcm38_snp_tran/genome_snp_tran"

mkdir $outdir

# go to FASTQ_trimmed directory
cd $dir

# declare an array variable
declare -a R=(*.fq.gz)
IFS=" " read -r -a samples <<< "$(echo "${R[@]//_*/}" | tr ' ' '\n' | sort -u | tr '\n' ' ')"

len=${#samples[@]}

# mapping and indexing
for ((i=0; i<$len; i++)); do
  mkdir $outdir/"${samples[$i]}"
  declare -a input=(${samples[$i]}*.fq.gz)
  inputfiles=($(echo "${input[@]}" | sed "s/ /,/g"))
  output=($(echo "${samples[$i]}" | sed "s/$/.sam/g"))
  hisat2 -p 6 --rna-strandness R -x $indexdir -U $inputfiles -S "$outdir"/"${samples[$i]}"/"$output"
  cd  $outdir/"${samples[$i]}"
  sam=$(echo "${samples[$i]}.sam")
  bam=$(echo "${samples[$i]}.bam")
  sortedbam=$(echo "${samples[$i]}_sorted.bam")
  samtools view -bS $sam > $bam
  samtools sort $bam -o $sortedbam
  samtools index $sortedbam
  cd $dir
done
