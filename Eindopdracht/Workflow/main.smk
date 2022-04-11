configfile: "../Config/config.yaml"

include: "Cutadapt.smk"
include: "Mapping.smk"
include: "SamTools-Sort.smk"
include: "SamTools-Index.smk"
include: "bfctools.smk"
include: "Quality.smk"
include: "SampleRetriever.smk"

rule all:
    input:
       "../Results/plots/quals.svg"
    log:
        "../Results/logs/all.log"
