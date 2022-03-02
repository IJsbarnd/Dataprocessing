from os.path import join
DATA_DIR = "C:\Users\hp\Documents\GitHub\Dataprocessing\Tutorial_02\Resources\data"

SAMPLES_DIR = 'samples/'
SAMPLES = ["A", "B", "C", "D"]

rule all:
    input:
        "Results/Rewrite/out.html"

rule bwa_map:
    input:
        genome = join(DATA_DIR, "genome.fa"),
        fastq = join(DATA_DIR, SAMPLES_DIR, "{sample}.fastq")
    output:
        "Results/Rewrite/mapped_reads/{sample}.bam"
    message:
        "executing bwa mem on the following {input} to generate the following {output}"
    shell:
        "bwa mem {input} | samtools view -Sb - > {output}"

rule samtools_sort:
    input:
        "Results/Rewrite/mapped_reads/{sample}.bam"
    output:
        "Results/Rewrite/sorted_reads/{sample}.bam"
    message:
        "executing samtools sort on the following {input} to generate the following {output}"
    shell:
        "samtools sort -T sorted_reads/{wildcards.sample} "
        "-O bam {input} > {output}"

rule samtools_index:
    input:
        "Results/Rewrite/sorted_reads/{sample}.bam"
    output:
        "Results/Rewrite/sorted_reads/{sample}.bam.bai"
    message:
        "executing samtools index on the following {input} to generate the following {output}"
    shell:
        "samtools index {input}"

rule bcftools_call:
    input:
        fa=join(DATA_DIR, "genome.fa"),
        bam=expand("Results/Rewrite/sorted_reads/{sample}.bam", sample=SAMPLES),
        bai=expand("Results/Rewrite/sorted_reads/{sample}.bam.bai", sample=SAMPLES)
    output:
        "Results/Rewrite/calls/all.vcf"
    message:
        "executing samtools mpileup and bfctools call on the following {input.fa} and {input.bam} to generate the following {output}"
    shell:
        "samtools mpileup -g -f {input.fa} {input.bam} | "
        "bcftools call -mv -O v - > {output}"

rule report:
    input:
        "Results/Rewrite/calls/all.vcf"
    output:
        html="Results/Rewrite/out.html"
    message:
        "Creating report from {input} to generate the following {output} output won't have inbedded file due to errors"
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
        """, output[0], metadata="Author: Lisan Eisinga", T1=input[0])