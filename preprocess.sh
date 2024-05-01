#!/bin/bash

# standard preprocessing pipeline

# folder where preprocessing data will be saved
wkdir=$1
# folder where nanopore raw data (FAST5) are stored
input_folder=$2
# 16S_ONT_preprocessreads repo folder
repo=$3

# update this
qcrep=${wkdir}/qc_reports/
filt=${wkdir}/length_filtered/

# go into main wkdir
cd ${wkdir}

# create necessary folders
mkdir -p ${qcrep}
mkdir -p ${filt}

# Quality control on unprocessed reads
echo -e "\n... ... ... ... Starting QC1.1 ... ... ... ... \n"
bash ${repo}/scripts/qc.sh ${bcalled}/pass/ raw_1 ${qcrep}
echo -e "\nStep done!\n"

# Quality control on unprocessed reads
echo -e "\n... ... ... ... Starting QC1.2 ... ... ... ... \n"
bash ${repo}/scripts/qc.sh ${bcalled}/pass/ raw_2 ${qcrep}
echo -e "\nStep done!\n"

# Trimming 
# ...



##### old
# # Demultiplexing
# echo -e "\n... ... ... ... Starting demultiplexing and barcode trimming ... ... ... ... \n"
# bash ${repo}/scripts/demultiplex.sh ${bcalled}/pass/ ${demux}
# echo -e "\nStep done!\n"
# 
# # Length filtering
# echo -e "\n... ... ... ... Starting filtering by length ... ... ... ... \n"
# bash ${repo}/scripts/lengthfilt.sh ${demux} ${filt}
# echo -e "\nStep done!\n"
# 
# # Quality control on processed reads
# echo -e "\n... ... ... ... Starting QC2 ... ... ... ... \n"
# bash ${repo}/scripts/qc.sh ${filt} preprocessed ${qcrep}
# echo -e "\nStep done!\n"
# 
# # MultiQC
# echo -e "\n... ... ... ... Starting multiQC ... ... ... ... \n"
# bash ${repo}/scripts/multiqc.sh ${qcrep}
# echo -e "\nStep done!\n"
# 
# 
