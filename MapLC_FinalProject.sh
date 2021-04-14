#!/bin/sh

#########################################################
#File Name: MapLC_FinalProject.sh
#By: Tori Coutts
#Date: 4/1/21
#########################################################

###literally the same as Map_FinalProject.sh, only with the common crossbill samples and reference genome
###load necessary modules
module load hisat2
module load stringtie/1.3.3
module load python/2.7.1
module load gcc/9.3.0
module load bcftools/1.2
module load gffread/
module load gffcompare/

ulimit -s unlimited

set -x

###call necessary directories and the reference genome
DATADIR=/scratch/aubclsa0105/FinalProject/Trimmed/Loxia_curvirostra
REFDIR=/scratch/aubclsa0105/FinalProject/Genomes/Loxia_curvirostra
OUTDIR=/scratch/aubclsa0105/FinalProject/LCMapped
COUNTSDIR=/scratch/aubclsa0105/FinalProject/LCballgown
RESULTSDIR=/scratch/aubclsa0105/FinalProject/LCCounts

REF2=Loxia_curvirostra

###make new directories
mkdir -p $OUTDIR
mkdir -p $COUNTSDIR
mkdir -p $RESULTSDIR

###index the genome
cd $REFDIR

##this step is needed because I need to convert a .gff to a .gtf
gffread $REF2.gff -T -o $REF2.gtf
extract_splice_sites.py $REF2.gtf > $REF2.ss
extract_exons.py $REF2.gtf > $REF2.exon
hisat2-build -ss $REF2.ss --exon $REF2.exon $REF2.fna.gz $REF2_index

###create a list of the samples
cd $DATADIR

ls | grep ".fastq" |cut -d "_" -f 1|sort | uniq > list

###copy it to a new directory
cd $OUTDIR

cp $DATADIR/list

###HiSAT2: mapping
while read i;
do
	hisat2 -p 6 --dta --phred33	\
	-x "$REFDIR"/"$REF2"_index	\
	-1 "$DATADIR"/"$i"_1_paired.fastq  -2 "$DATADIR"/"$i"_2_paired.fastq	\
	-S "$i".sam

###samtools: converting .sam to .bam
samtools view -@ 6 -bS ${i}.sam > ${i}.bam
samtools sort -@ 6 "$i".bam	"$i"_sorted
samtools flagstat	"$i"_sorted.bam   > "Si"_Stats.txt

mkdir "$COUNTSDIR"/"$i"

###Stringtie: assembly
stringtie -p 6 -e -B -G "$REFDIR"/"$REF2".gtf

done<list

cp *.txt $RESULTSDIR

cd ..

###use the python script to receive a counts .csv file
python /home/aubclsa0105/class_shared/scripts/PrepDE.py $COUNTSDIR

cp *.csv $RESULTSDIR
