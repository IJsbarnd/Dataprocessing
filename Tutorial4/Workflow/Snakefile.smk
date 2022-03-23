datadir = '/commons/Themas/Thema11/Dataprocessing/WC04/data/'

rule all:
    """ final rule """
    input: 'result/heatmap.jpg'


rule make_histogram:
    """ rule that creates histogram from gene expression counts"""
    input:
        datadir + 'gene_ex.csv'
    output:
         'result/heatmap.jpg'
    shell:
        "Rscript heatmap.R {input} {output}"