#!/bin/sh

###same as Quality1, only these files have been trimmed and moved to separate directories by species
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load fastqc/0.10.1
module load gnu_parallel/201612222
module load gnu_parallel

###call and make directories
DATADIR1=/scratch/aubclsa0105/FinalProject/Trimmed/Sturnus_vulgaris
DATADIR2=/scratch/aubclsa0105/FinalProject/Trimmed/Loxia_curvirostra
OUTDIR=/scratch/aubclsa0105/FinalProject/QualityResults2

mkdir -p $OUTDIR

###move to the starling directory
cd $DATADIR1

###FastQC on the trimmed starling data
fastqc *_1_paired.fastq
fastqc *_2_paired.fastq
#ls *_1_paired.fastq | time parallel -j+0 --eta 'fastqc{}'
#ls *_2_paired.fastq | time parallel -j+0 --eta 'fastqc{}'

###move the new fastq files to the output directory
cp *fastqc* $OUTDIR

###move to the crossbill directory
cd $DATADIR2

###FastQC on the trimmed crossbill data
fastqc *_1_paired.fastq
fastqc *_2_paired.fastq
#ls *_1_paired.fastq | time parallel -j+0 --eta 'fastqc{}'
#ls *_2_paired.fastq | time parallel -j+0 --eta 'fastqc{}'

###move the new fastq files to the output directory
cp *fastqc* $OUTDIR
