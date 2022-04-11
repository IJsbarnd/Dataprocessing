rule getsamples:
    params:
        samples = config["Samples"],
        output_dir = config["wdir"] + "Resources/data/"
    output:
        config["wdir"]+"Resources/data/{sample}.fastq"
    threads:
        int(config["threads"])
    message:
        "Executing fastq-dump with {threads} threads on the following files {params.samples}"
    log:
        "../logs/download_{sample}.log"
    shell:
        "parallel-fastq-dump -t {threads} -s {params.samples} -O {params.output_dir} 2> {log}"