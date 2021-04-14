#!/bin/sh

#############################################
#File Name: Map_FinalProject.sh
#By: Tori Coutts
#Date: 4/1/21
#Last Edited: 4/12/21
#############################################

###load modules needed
module load hisat2
module load stringtie/1.3.3
module load python/2.7.1
module load gcc/9.3.0
module load bcftools/1.2
module load gffread/
module load gffcompare/

###set limit to unlimited
ulimit -s unlimited

###Turn echo on so all commands are echoed in the output log
set -x

###label directories
DATADIR=/scratch/aubclsa0105/FinalProject/Trimmed/Sturnus_vulgaris
REFDIR=/scratch/aubclsa0105/FinalProject/Genomes/Sturnus_vulgaris
OUTDIR=/scratch/aubclsa0105/FinalProject/Mapped
COUNTSDIR=/scratch/aubclsa0105/FinalProject/ballgown
RESULTSDIR=/scratch/aubclsa0105/FinalProject/Counts

###label reference genomes
REF=Sturnus_vulgaris

###make necessary directories
mkdir -p $OUTDIR
mkdir -p $COUNTSDIR
mkdir -p $RESULTSDIR

######Index reference genome (must be done because this is a newly downloaded genome)######
cd $REFDIR

###identify exons and splice sites
#gffread $REF.gff -T -o $REF.gtf
extract_splice_sites.py $REF.gtf > $REF.ss
extract_exons.py $REF.gtf > $REF.exon

###create index
hisat2-build --ss $REF.ss --exon $REF.exon $REF.fasta $REF_index

###change to working directory
cd $DATADIR

###sort reads in a list
ls | grep ".fastq" |cut -d "_" -f 1| sort | uniq > list

###change to output directory
cd $OUTDIR

###copy the list from the working directory
cp $DATADIR/list .

###HiSAT2
while read i;
do
	hisat2 -p 6 --dta --phred33	\
	-x "$REFDIR"/"$REF"_index	\
	-1 "$DATADIR"/"$i"_1_paired.fastq  -2 "$DATADIR"/"$i"_2_paired.fastq	\
	-S "$i".sam

###samtools
samtools view -@ 6 -bS ${i}.sam > ${i}.bam
samtools sort -@ 6 "$i".bam	"$i"_sorted
samtools flagstat    "$i"_sorted.bam   > "$i"_Stats.txt

###make directories specific to the sample
mkdir "$COUNTSDIR"/"$i"

###Stringtie
stringtie -p 6 -e -B -G "$REFDIR"/"$REF".gtf -o "$COUNTSDIR"/"$i"/"$i".gtf  -l "$i"  "$OUTDIR"/"$i"_sorted.bam

###end the while loop
done<list

###copy all stats to the results directory
cp *.txt $RESULTSDIR

###go back to the previous directory
cd ..

###use python script
python /home/aubclsa0105/class_shared/scripts/PrepDE.py $COUNTSDIR
cp *.csv $RESULTSDIR

