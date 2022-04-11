rule samtools_sort:
    input:
       config["wdir"]+"Results/mapped_reads/{sample}.bam"
    output:
        temp(config["wdir"]+"Results/sorted_reads/{sample}.bam")
    threads:
        int(config["threads"])
    message:
        "Executing 'samtools sort' with {threads} threads on {input}"
    log:
        "../logs/samtools_sort_{sample}.log"
    shell:
        "samtools sort -@ {threads} -T {output} -O bam {input} > {output} 2> {log}"