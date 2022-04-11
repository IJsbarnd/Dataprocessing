import matplotlib
import matplotlib.pyplot as plt
from pysam import VariantFile

matplotlib.use("Agg")

Qualitycheck = [record.qual for record in VariantFile(snakemake.input[0])]
plt.hist(Qualitycheck)

plt.savefig(snakemake.output[0])