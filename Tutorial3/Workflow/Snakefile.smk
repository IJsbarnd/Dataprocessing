wdir = "/homes/ijapool/PycharmProjects/Dataprocessing2/Tutorial3"
SAMPLES = ["A", "B", "C", "D"]

rule all:
    input:
        wdir + "/out.html"

rule bwa_map:
    input:
        wdir + "/data/genome.fa",
        wdir + "/data/samples/{sample}.fastq"
    output:
        wdir + "/mapped_reads/{sample}.bam"
    message: "executing bwa mem on the following {input} to generate the following {output}"
    shell:
        "bwa mem {input} | samtools view -Sb - > {output}"

rule samtools_sort:
    input:
        wdir + "/mapped_reads/{sample}.bam"
    output:
        wdir + "/sorted_reads/{sample}.bam"
    message:
        "message"
    shell:
        "samtools sort -T sorted_reads/{wildcards.sample} "
        "-O bam {input} > {output}"

rule samtools_index:
    input:
        wdir + "/sorted_reads/{sample}.bam"
    output:
        wdir + "/sorted_reads/{sample}.bam.bai"
    message:
        "message"
    shell:
        "samtools index {input}"

rule bcftools_call:
    input:
        fa=wdir + "/data/genome.fa",
        bam=expand(wdir + "/sorted_reads/{sample}.bam", sample=SAMPLES),
        bai=expand(wdir + "/sorted_reads/{sample}.bam.bai", sample=SAMPLES)
    output:
        wdir + "/calls/all.vcf"
    message:
        "message"
    shell:
        "samtools mpileup -g -f {input.fa} {input.bam} | "
        "bcftools call -mv - > {output}"

rule report:
    input:
        wdir + "/calls/all.vcf"
    output:
        wdir + "/out.html"
    message:
        "message"
    run:
        from snakemake.utils import report

        with open(input[0]) as f:
            n_calls = sum(1 for line in f if not line.startswith("#"))

        report("""
        An example workflow
        ===================================

        Reads were mapped to the Yeas reference genome 
        and variants were called jointly with
        SAMtools/BCFtools.

        This resulted in {n_calls} variants (see Table T1_).
        """,output[0],metadata="Author: Mr Pipeline",T1=input[0])
