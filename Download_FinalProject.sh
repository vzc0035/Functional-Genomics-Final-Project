#!/bin/sh

#############################
#Created by: Tori Coutts
#for downloading final project data from NCBI
#############################

###load the necessary modules
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load sra

###create new directory for data
DATADIR=/scratch/aubclsa0105/FinalProject/RawData

mkdir -p $DATADIR

###change to this directory so files will download in the right place
cd $DATADIR

###download the files from NCBI
fastq-dump -F --split-files	SRR9644977
fastq-dump -F --split-files	SRR9644980
fastq-dump -F --split-files	SRR9644981
fastq-dump -F --split-files	SRR9644982
fastq-dump -F --split-files	SRR9644983
fastq-dump -F --split-files	SRR9644984
fastq-dump -F --split-files	SRR9644985
