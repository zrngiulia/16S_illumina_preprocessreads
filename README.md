# 16S_illumina_preprocessreads
From Illumina raw PE reads (16S seq) to polished FASTQ files, ready to undergo taxonomical classification.

# Reads information
Paired End reads obtained by Illumina sequencing, PE250.
Primers for bacterial 16S rRNA gene V4 amplification:

* 515F: 5'-GTGCCAGCMGCCGCGGTAA-3'
* 806R: 5'-GGACTACHVGGGTWTCTAAT-3'

Barcodes are listed in 01.RawData/SampleSeq_info.xls. Reads are already demultiplexed and placed in individual folders in 01.RawData.

* *.raw_1.fq.gz [Read 1 sequences with barcodes and primers]
* *.raw_2.fq.gz [Read 2 sequences with barcodes and primers]
* *_1.fastq.gz [Read 1 sequences with barcode and primer removed]
* *_2.fastq.gz [Read 2 sequences with barcode and primer removed]
* *.extendedFrags.fastq.gz [Merged reads]

## Steps and software

* Quality control: FastQC. https://www.bioinformatics.babraham.ac.uk/projects/fastqc/
* Trimming: AdapterRemoval. https://adapterremoval.readthedocs.io/en/stable/index.html
  Adapters at the 3' of reads, barcodes, low quality bases (minq=28) removed. --barcode-list barcodes.txt to point to the barcodes files
  Trimmomatic http://www.usadellab.org/cms/?page=trimmomatic
  Demultiplexed sequence files are subject to quality filtering using Trimmomatic [32] version 0.30, with a hard cutoff of PHRED score Q3 for 5′ and 3′ ends of the reads (parameters LEADING: 3 and TRAILING: 3), trimming of the 3′ end with a moving average score of Q15, with a window size of 4 bases (parameter SLIDINGWINDOW: 4:15), and removing any remaining reads shorter than 75% [10] of the original read length (for example, parameter MINLEN: 112 for 150 bp long reads, MINLEN: 187 for 250 bp long reads or MINLEN: 225 for 300 bp long reads). Reads with any ambiguous base calls are discarded.
* Merging: UPARSE or AdapterRemoval
* Chimera removal: UCHIME
* Filter by length
* OTU picking (SUMACLUST groups reads by 97% similarity threshold, as this is what is usually considered as the identity threshold to group sequences from the same species, and then picks a representative consensus sequence for that cluster), or ASV prediction (by calculation of the probability that a given sequenced read is due to error or if it is a real sequence, and counts identical sequences finally providing ASVs)
* Taxonomy assignment to the OTUs or ASVs sequences (seqs can be blasted using QIIME against a reference database such as SILVA, rrnDB, GreenGenes, NCBI nucleotide (nt))
