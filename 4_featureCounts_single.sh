#!/bin/bash

# directory and file
dir="/Volumes/Expansion/Bulk_RNAseq_Run/MappingResults"
outdir="/Volumes/Expansion/Bulk_RNAseq_Run/Counts"
gtf="/Volumes/Expansion/mm10_references/gencode.vM25.annotation.gtf"

mkdir $outdir

# go to the directory where your merged BAM files locate
cd $dir

# variables
IFS=" " read -r -a files <<< "$(find . | grep sorted | grep -v bai | tr ' ' '\n' | sort -u | tr '\n' ' ')"
input=$(echo "${files[@]}")

# featureCounts (ensembl IDs)
featureCounts -T 6 -s 2 -a $gtf -o $outdir/result_ensemblIDs.txt $input # T is the number of threads, -s 2 specifies strand-specific read counting (reversely stranded reads)

# featureCounts (gene symbols)
featureCounts -T 6 -s 2 -g gene_name -a $gtf -o $outdir/result_genenames.txt $input # T is the number of threads, -s 2 specifies strand-specific read counting (reversely stranded reads)
