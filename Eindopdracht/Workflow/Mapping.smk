rule bwa_map:
    input:
        config["refgenome"],
        config["wdir"]+"Results/cut_reads/{sample}.fastq"
    output:
        temp(config["wdir"]+"Results/mapped_reads/{sample}.bam")
    threads:
        int(config["threads"])
    message:
        "Executing 'bwa mem' with {threads} threads on {input}"
    log:
        "../logs/bwa_mem_{sample}.log"
    shell:
        "(bwa mem -t {threads} -M {input} | samtools view -Sb - > {output}) 2> {log}"