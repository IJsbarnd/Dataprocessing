# Repository of Dataprocessing course WC01 #
__Author__: Lisan Eisinga  
__Date__: 16/02/2022 
__Course__: Dataprocessing Thema 11 2022 

## Table of content

- [Project description](#project-description)
- [Installation](#installation)
    * [Needed](#needed)
- [Command examples](#command-examples)
- [Contact](#contact)

## Project description
This Github file contains the assignment WC-01, this is the first of five assignments for the Dataprocessing course, all the executable files within this folder are `.smk` files, this means that snakemake is required before the script is executable on the terminal.

## Installation
To be able to run this project snakemake package is required. A terminal which can run windows or linux commands is also required.

### Needed
In order to be able to run the code within this file, snakemake is needed, on windows this can be installed as such: `pip install snakemake`

After this command is run on windows while using Conda the following command is required to be able to generate images of the pipeline: `conda install graphviz`

After both commands have been executed in the correct virtual environment the pipeline is fully capable of being executed.

## Command examples
In order to be able to run the pipeline, a command as this can be used:
`snakemake --snakefile Snakefile.smk -c1`

The `-c1` command here expresses the amount of cores, this is a required argument or the pipeline will not run.

In order to generate an image the following command can be used:
`snakemake --snakefile Snakefile.smk --dag | dot -Tpng > dag.png`

## Contact
Please contact the email below for any questions regarding the pipeline.
* j.l.a.eisinga@st.hanze.nl