#!/bin/sh

#############################################################
#Title: Trim_FinalProject.sh
#By: Tori Coutts
#Date Created: 3/29/21
#Last Edited: 4/2/21
#############################################################

###load necessary modules
source /opt/asn/etc/asn-bash-profiles-special/modules.sh
module load fastqc/0.10.1
module load trimmomatic

###define the directories you are working with
##directory that contains raw data files
DATADIR=/scratch/aubclsa0105/FinalProject/RawData/RawData_assessed
##directory that the trimmed files will be in
WORKDIR=/scratch/aubclsa0105/FinalProject/Trimmed

###make the new working directory
mkdir -p $WORKDIR

###change to the data directory to make the list
cd $DATADIR

###make a list of all files to be trimmed
ls | grep ".fastq" |cut -d "_" -f 1 | sort | uniq > list

###move this list to the working directory so trimmomatic can work with these files in the new directory
mv list $WORKDIR

###change to the working directory
cd $WORKDIR

###copy the fasta file containing Illumina adapter sequences
cp /home/aubclsa0105/class_shared/AdaptersToTrim_All.fa .

###create a while loop to trim multiple files using Trimmomatic
while read i
do
java -jar /mnt/beegfs/home/aubmxa/.conda/envs/BioInfo_Tools/share/trimmomatic-0.39-1/trimmomatic.jar PE -threads 6 -phred33 \
	$DATADIR/"$i"_1.fastq $DATADIR/"$i"_2.fastq \
	"$i"_1_paired.fastq "$i"_1_unpaired.fastq	\
	"$i"_2_paired.fastq "$i"_2_unpaired.fastq	\
	ILLUMINACLIP:AdaptersToTrim_All.fa:2:35:10 LEADING:30 TRAILING:30 SLIDINGWINDOW:5:35

done<list
