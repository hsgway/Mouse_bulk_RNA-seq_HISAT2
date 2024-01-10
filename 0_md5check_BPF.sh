#!/bin/bash

# file and directory
md5file="xxx.md5"
md5file_new="xxx_new.md5"
dir="Path_to_FASTQ_directory"

# modify md5 file
cat $md5file | sed -e 's/\/data\/users\/xxx\///g' > $md5file_new

# go to the folder containing your files
cd $dir

# md5 check
md5sum --check $md5file_new

# optional: get md5
# find -s . -type f -exec md5sum {} \; > /Volumes/Expansion/Bulk_RNAseq_Run/FASTQ/checksums.md5
