#!/bin/sh

######################################
#Title: DownloadGenomes_FinalProject.sh
#By: Tori Coutts
#Date: 3/31/21
#Last Edited: 4/6/21
######################################

###create a directory for the files to go to
OUTDIR=/scratch/aubclsa0105/FinalProject/Genomes

mkdir -p $OUTDIR

###change to this directory so the files end up in the proper place
cd $OUTDIR

###download the files from the web
wget -O Sturnus_vulgaris.fna.gz https://ftp.ncbi.nih.gov/genomes/genbank/vertebrate_other/Sturnus_vulgaris/latest_assembly_versions/GCA_001447265.1_Sturnus_vulgaris-1.0/GCA_001447265.1_Sturnus_vulgaris-1.0_genomic.fna.gz
wget -O Sturnus_vulgaris.gbff.gz https://ftp.ncbi.nih.gov/genomes/genbank/vertebrate_other/Sturnus_vulgaris/latest_assembly_versions/GCA_001447265.1_Sturnus_vulgaris-1.0/GCA_001447265.1_Sturnus_vulgaris-1.0_genomic.gbff.gz
wget -O Sturnus_vulgaris.gtf.gz https://ftp.ncbi.nih.gov/genomes/refseq/vertebrate_other/Sturnus_vulgaris/latest_assembly_versions/GCF_001447265.1_Sturnus_vulgaris-1.0/GCF_001447265.1_Sturnus_vulgaris-1.0_genomic.gtf.gz

wget -O Loxia_curvirostra.fna.gz https://ftp.ncbi.nih.gov/genomes/genbank/vertebrate_other/Loxia_curvirostra/latest_assembly_versions/GCA_013398455.1_ASM1339845v1/GCA_013398455.1_ASM1339845v1_genomic.fna.gz
wget -O Loxia_curvirostra.gbff.gz https://ftp.ncbi.nih.gov/genomes/genbank/vertebrate_other/Loxia_curvirostra/latest_assembly_versions/GCA_013398455.1_ASM1339845v1/GCA_013398455.1_ASM1339845v1_genomic.gbff.gz
wget -O Loxia_curvirostra.gff.gz https://ftp.ncbi.nih.gov/genomes/genbank/vertebrate_other/Loxia_curvirostra/latest_assembly_versions/GCA_013398455.1_ASM1339845v1/GCA_013398455.1_ASM1339845v1_genomic.gff.gz
wget -O Loxia_curvirostra.gtf.gz https://ftp.ncbi.nih.gov/genomes/genbank/vertebrates_other/Loxia_curvirostra/latest_assembly_versions/GCA_013398455.1_ASM1339845v1/GCA_013398455.1_ASM1339845v1_genomic.gtf.gz
