rule cutadapt:
    input:
        config["wdir"]+"Resources/{sample}.fastq"
    output:
        config["wdir"]+"Results/cut_reads/{sample}.fastq"
    shell:
        "cutadapt -a CTGTCTCTTATACACATCT -o {output} {input}"