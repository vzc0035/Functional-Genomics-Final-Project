#!/bin/sh

################################################################
#Title: Quality1_FinalProject.sh
#Made by: Tori Coutts
#Date: 03/29/2021
################################################################

###loading different modules to be able to run the script in parallel AND normally
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load fastqc/0.10.1
module load gnu_parallel/201612222
module load gnu_parallel

###calling and making directories
DATADIR=/scratch/aubclsa0105/FinalProject/RawData
OUTDIR=/scratch/aubclsa0105/FinalProject/QualityResults1

mkdir -p $OUTDIR

###change to the working directory
cd $DATADIR

###use FastQC; there are two ways to do this. Another way is commented out
fastqc *_1.fastq
fastqc *_2.fastq
#ls *_1.fastq | time parallel -j+0 --eta 'fastqc {}'
#ls *_2.fastq | time parallel -j+0 --eta 'fastqc {}'

###move all quality files to the new directory
mv *fastqc* $OUTDIR
