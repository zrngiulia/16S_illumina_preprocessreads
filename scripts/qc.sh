#!/bin/bash

input_folder=$1
# si aspetta 'raw_1' o 'raw_2' o simile
stage=$2
output_folder=$3


zcat $(find ${input_folder} -type f -regex ".+${stage}.+") > ${output_folder}/${stage}.fastq
#run fastqc on all.fastq
command="fastqc -t 4 ${output_folder}/${stage}.fastq -o ${output_folder}"

echo $command

$command
