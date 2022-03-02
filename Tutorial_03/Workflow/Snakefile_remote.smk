from snakemake.remote.HTTP import RemoteProvider as HTTPRemoteProvider

HTTP = HTTPRemoteProvider()

rule all:
    input:
        "Results/remote/test.txt"

rule get_data_bioinf:
    input:
        HTTP.remote("https://bioinf.nl/~fennaf/snakemake/test.txt")
    output:
        "Results/remote/test.txt"
    shell:
        "mv {input} {output}"