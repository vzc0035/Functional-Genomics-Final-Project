# Functional-Genomics-Final-Project

# These are all the scripts I used and created for the final project in Functional Genomics. In this project, I wanted to investigate how differential gene expression could explain differences in immunity of avian malaria between the common starling (Sturnus vulgaris) and the common crossbill (Loxia curvirostra). Below lists the script names and what each script intends to do.

# Download_FinalProject.sh
# This script was used to download the RNA-seq data from NCBI's SRA database.

# DownloadGenomes_FinalProject.sh
# This script was used to download the reference genomes and annotations needed for the mapping scripts.

# Quality1_FinalProject.sh
# This script was used to analyze the quality of the RNA-seq read data.

# Trim_FinalProject.sh
# This script was used to trim the RNA-seq reads based on quality.

# Quality2_FinalProject.sh
# This script was used for analyzing the quality of the trimmed reads.

# Map_FinalProject.sh
# This script will be used to map and assemble the common starling (Sturnus vulgaris) samples.

# MapLC_FinalProject.sh
# Since I am working with two different species mapping to two separate reference genomes, I had to create two separate scripts; one for each species. Here, I moved all of the trimmed files to separate directories corresponding to the species the data came from so they could be mapped and assembled separately. This script is for the common crossbill (Loxia curvirostra) samples.
