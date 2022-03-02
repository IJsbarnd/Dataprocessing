'''
Main script to be executed.
Includes all necessary Snakefiles needed
to execute the workflow.
'''

configfile: "Config/config.yaml"

include: "workflow/Snakefile_WC02_rewrite.smk"
include: "Workflow/Snakefile_merging.smk"
include: "workflow/Snakefile_NCBI.smk"
include: "workflow/Snakefile_remote.smk"

rule all:
    input:
        ''