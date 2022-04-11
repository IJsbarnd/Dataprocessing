# Repository of Dataprocessing final assignment #
__Author__: IJsbrand Pool  
__Date__: 11/04/2022  
__Course__: Dataprocessing Thema 11 2022 

## Table of content

- [Project description](#project-description)
- [Requirements](#Requirements)
- [Installation](#Installation)
- [Rules](#Rules)
- [Command examples](#command-examples)
- [Contact](#contact)

## Project description
This repository is for the final assignment for the course dataprocessing, for this course a derivation on the Fast-GBS pipeline was created in a snakemake and python format. The Fast-GBS pipeline uses a large range of tools for the Genotyping-by-sequencing, this project has implemented some of those tools and remade them using the snakemake format. This project will also include a quality measurement.

The pipeline comes from this [article](https://bmcbioinformatics.biomedcentral.com/track/pdf/10.1186/s12859-016-1431-9.pdf). 


### Requirements
In order to correctly run the pipeline the following packages need to be installed on the system:
```
* Python (Version 3.7 or higher)
* matplotlib (Version 3.5.1)
* Pysaml2 (Version 7.1.2)
* Snakemake (Version 5.32.2)
* ggplot2 (Version 3.3.5)
* BWA-map (Version 0.6 or higher)
* Cutadapt (Version 3.7)
* Samtools (Version 1.15)
```

## Installation
First make sure to clone or download this repo to get all the correct and updated scripts.

Note: Step three can be skipped if there are already FastQ files present.

* Step 1: After cloning the repo download the data, download your data, this would be FastQ files and a reference genome, for this project specifically the Glycine max (soybean) genome was used and two FastQ files were used.

* Step 2: After the data has been downloaded, the Genome needs to be indexed, this can be done with BWA-map using the following command: `bwa index [genomefile]`. This will result in multiple index files for the genome, and the project will not run properly if this step is skipped.

* Step 3: The SRA files need to be converted to FastQ files. In order to do this the SRA toolkit can be installed or any other SRA converter.

With the SRA toolkit open your terminal and use the following command: `prefetch SRR2073061` and the same for the other files.

* Step 4: A virtual environment can also be created for this project although this is optional. This is achieved with the following commands:
```
pip install virtualenv
virtualenv data_processing
source data_processing/venv/bin/activate
```
* Step 5: The pipeline can be run with the following command: `snakemake --snakefile snakemake_main.smk -c8` or `snakemake --snakefile snakemake_main.smk --jobs` This will run the entire pipeline and create the quality checker image and the total overview of the pipeline.

## Rules
`rule cutadapt:` <br />
Finds and removes adapter sequences. <br />
`rule bwa_map:` <br />
Mapping low-divergent sequences against a large reference genome <br />
`rule samtools_sort:` <br />
Align FASTQ files with all current sequence aligners <br />
`rule samtools_index:` <br />
Quickly extracts alignments overlapping on particular genomic regions. <br />
`rule bcftools_call:` <br />
Variant calling by making use of the reference genome <br />
`rule plot_quality:` <br />
Plots the quality of the reads by making use of Quality.py <br />
`rule dag_file:` <br />
Creates the dag file that represents the steps from the pipeline.

## Command examples
In order to be able to run the pipeline, a command as this can be used:
`snakemake --snakefile main.smk -c1`

The `-c1` command here expresses the amount of cores, this is a required argument or the pipeline will not run.

In order to generate an image the following command can be used:
`snakemake --snakefile Snakefile.smk --dag | dot -Tpng > ../Results/dag.png`

## Contact
Please contact the email below for any questions regarding the pipeline.
* i.j.a.pool@st.hanze.nl