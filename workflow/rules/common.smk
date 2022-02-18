import pandas as pd
import datetime
import time

configfile: 'config.yaml'

threads_high = 36
threads_mid = int(threads_high/2)
threads_low = 2

# Load in metadata
metadata_file = "metadata.tsv"
metadata_df = pd.read_csv(metadata_file, sep = "\t").set_index('sample_name', drop=False)
# validate(metadata_df, schema="schemas/metadata_schema.yaml")

# Setup samplesheet
samples = metadata_df.index.tolist()

def get_fastq(wildcards):
    return metadata_df.loc[(wildcards.sample), ["r1", "r2"]]
