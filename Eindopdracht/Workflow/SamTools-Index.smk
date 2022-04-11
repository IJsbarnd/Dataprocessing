rule samtools_index:
    input:
        config["wdir"]+"Results/sorted_reads/{sample}.bam"
    output:
        config["wdir"]+"Results/sorted_reads/{sample}.bam.bai"
    message:
        "Executing 'samtools index' on {input}"
    log:
        "../logs/samtools_index_{sample}.log"
    shell:
        "samtools index  {input} 2> {log}"