import os
from snakemake.remote.NCBI import RemoteProvider as NCBIRemoteProvider
NCBI = NCBIRemoteProvider(email="j.l.a.eisinga@st.hanze.nl") # email required by NCBI

rule all:
    input:
        "results/ncbi_improved/sequence.fasta"

rule get_data:
    input:
        NCBI.remote("KY785484.1.fasta", db="nuccore")
    output:
        "Results/"
    run:
        shell("mv {input} {output}")