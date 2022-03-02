SAMPLES = ["A", "B", "C", "D"]

rule all:
    input:
        "Results/output.html"

rule bwa_map:
    input:
        genome ="Resources/genome.fa",
        sample ="Resources/samples/{sample}.fastq"
    output:
        "Results/mapped_reads/{sample}.bam"
    benchmark:
        "Results/benchmarks/{sample}.bwa.benchmark.txt"
    message:
        "executing bwa mem on the following {input} to generate the following {output}"
    shell:
        "bwa mem {input.genome} {input.sample} | samtools view -Sb - > {output}"

rule samtools_sort:
    input:
         "Results/mapped_reads/{sample}.bam"
    output:
         "Results/sorted_reads/{sample}.bam"
    message:
         "executing samtools sort on the following {input} to generate the following {output}."
    shell:
         "samtools sort -T sorted_reads/{wildcards.sample}"
         " -O bam {input} > {output}"

rule sametools_index:
    input:
        "Results/sorted_reads/{sample}.bam"
    output:
        "Results/sorted_reads/{sample}.bam.bai"
    message:
        "executing samtools index on the following {input} to generate the following {output}."
    shell:
        "samtools index {input}"

rule bcftools_call:
    input:
        fa = "Resources/genome.fa",
        bam = expand("Results/sorted_reads/{sample}.bam", sample = SAMPLES),
        bai = expand("Results/sorted_reads/{sample}.bam.bai", sample = SAMPLES)
    output:
        "Results/calls/all.vcf"
    message:
        "executing samtools and bcftools on the following {input} to generate the following {output}."
    shell:
        "samtools mpileup -g -f {input.fa} {input.bam} | "
        "bcftools call -mv - > {output}"

rule report:
    input:
        "Results/calls/all.vcf"
    output:
        "Results/output.html"
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

