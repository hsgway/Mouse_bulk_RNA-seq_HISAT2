#!/bin/bash

# file and directory
md5file="/Volumes/TOSHIBA/20220729_TimeCourse_Colon/0_FASTQ/FC_07570/Unaligned_12_PF_mm1/FC_07570_Unaligned_12_PF_mm1.md5"
md5file_new="/Volumes/TOSHIBA/20220729_TimeCourse_Colon/0_FASTQ/FC_07570/Unaligned_12_PF_mm1/FC_07570_Unaligned_12_PF_mm1_new.md5"
dir="/Volumes/TOSHIBA/20220729_TimeCourse_Colon/0_FASTQ"

# modify md5 file
cat $md5file | sed -e 's/\/data\/users\/yhasegawa\///g' > $md5file_new

# go to the folder containing your files
cd $dir

# md5 check
md5sum --check $md5file_new

# optional: get md5
# find -s . -type f -exec md5sum {} \; > /Volumes/Expansion/Bulk_RNAseq_Run/FASTQ/checksums.md5
