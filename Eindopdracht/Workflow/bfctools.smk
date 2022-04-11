rule bcftools_call:
    input:
        fa=config["refgenome"],
        bam=expand(config["wdir"]+"Results/sorted_reads/{sample}.bam", sample=config["Samples"]),
        bai=expand(config["wdir"]+"Results/sorted_reads/{sample}.bam.bai", sample=config["Samples"]),
    output:
        "../Results/calls/all.vcf"
    threads:
        int(config["threads"])
    message:
        "Executing 'samtools mpileup' and bcftools call with {threads} threads on {input}"
    shell:
        "samtools mpileup -g -f {input.fa} {input.bam} | "
        "bcftools call --threads {threads} -mv - > {output} "