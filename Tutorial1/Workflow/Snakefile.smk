SAMPLES = ['Sample1', 'Sample2', 'Sample3']

rule all:
    input:
        'Results/test.txt'

rule quantify_genes:
    input:
        genome = '../data/genome.fa',
        r1 = '../data/{sample}.R1.fastq.gz',
        r2 = '../data/{sample}.R2.fastq.gz'
    output:
        'Results/{sample}.txt'
    shell:
        'echo {input.genome} {input.r1} {input.r2} > {output}'

rule send_to_test:
    input:
        expand('Results/{sample}.txt',sample=SAMPLES)
    output:
        'Results/test.txt'
    run:
        with open(output[0],'w') as out:
            for i in input:
                sample = i.split('.')[0]
            for line in open(i):
                out.write(sample + '' + line + ' Are processed correctly')

rule clean:
    shell:
        'rm -r Results/'