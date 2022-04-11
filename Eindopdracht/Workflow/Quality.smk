rule plot_quals:
    input:
        "../Results/calls/all.vcf"
    output:
        "../Results/plots/quals.svg"
    script:
        "Quality-Plotter.py"