import pandas as pd
import datetime
import time

threads_high = 36
threads_mid = int(threads_high/2)
threads_low = 2

# Load in metadata
metadata_file = "metadata.tsv"
metadata_df = pd.read_csv(metadata_file, sep = "\t").set_index('sample_name', drop=False)
# validate(metadata_df, schema="schemas/metadata_schema.yaml")

# Setup samplesheet
samples = metadata_df.index.tolist()

# Convert df to dict for trt/ctrl pairing
metadata_dict = metadata_df.to_dict('index')
chip_samples = [sample for sample in metadata_dict if metadata_dict[sample]['type'] == "ip"]

def get_fastq(wildcards):
	return metadata_df.loc[(wildcards.sample), ["r1", "r2"]]

def get_input_bam(wildcards):
    return "results/bam/{input_name}/{input_name}.Aligned.sortedByCoord.out.bam".format(input_name = metadata_df.loc[(wildcards.chip_sample), "input"])
