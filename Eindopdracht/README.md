# Repository of Dataprocessing final assignment #
__Author__: IJsbrand Pool  
__Date__: 11/04/2022  
__Course__: Dataprocessing Thema 11 2022 

## Table of content

- [Project description](#project-description)
- [Installation](#installation)
    * [Needed](#needed)
- [Command examples](#command-examples)
- [Contact](#contact)

## Project description
This repository is for the final assignment for the course dataprocessing, for this course a derivation on the Fast-GBS pipeline was created in a snakemake and python format. The Fast-GBS pipeline uses a large range of tools for the Genotyping-by-sequencing, this project has implemented some of those tools and remade them using the snakemake format. This project will also include a quality measurement.

The pipeline comes from this [article](https://bmcbioinformatics.biomedcentral.com/track/pdf/10.1186/s12859-016-1431-9.pdf). 


## Installation
To be able to run this project snakemake package is required. A terminal which can run windows or linux commands is also required.

### Needed
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

## Command examples
In order to be able to run the pipeline, a command as this can be used:
`snakemake --snakefile Snakefile.smk -c1`

The `-c1` command here expresses the amount of cores, this is a required argument or the pipeline will not run.

In order to generate an image the following command can be used:
`snakemake --snakefile Snakefile.smk --dag | dot -Tpng > dag.png`

## Contact
Please contact the email below for any questions regarding the pipeline.
* j.l.a.eisinga@st.hanze.nl