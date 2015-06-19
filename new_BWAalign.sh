#!/bin/bash

#this script is for bwa mapping fastq files to a reference library.

#Indexing reference library (the dictionary and the .fai index files will be needed tomorrow):

bwa index -p assembly -a is ./assembly/Trinity.fasta

Dictionary="./assembly/Trinity.dict"

if [ -f  "$Dictionary" ];
then
        echo "Trinity.dict already created"
else
        echo "file does not exist"
         java -jar ../scripts/CreateSequenceDictionary.jar R= ./assembly/Trinity.fasta O= ./assembly/Trinity.dict
fi

samtools faidx ./assembly/Trinity.fasta

#Mapping and converting to SAM file format:

#For Single End lanes:
#Add your personal alignment parameters to each line before executing the script. We will leave -t (number of threads) to 2.


for i in *.clipped.fastq;
do
        echo working with "$i"
        newfile="$(basename $i .clipped.fastq)"
        bwa aln -n .01 -k 5 -l 30 -t 2 assembly $i |bwa samse assembly - $i | AddReadGroup.pl -i - -o ${newfile}.sam -r ${newfile} -s ${newfile} -l ${newfile} -p Illumina


done;

