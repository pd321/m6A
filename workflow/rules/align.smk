rule star:
	input: 
		rules.trimgalore.output
	output:
		wig = temp("results/bam/{sample}/{sample}.Signal.Unique.str1.out.wig"),
		wig_mult = temp("results/bam/{sample}/{sample}.Signal.UniqueMultiple.str1.out.wig"),
		bam = "results/bam/{sample}/{sample}.Aligned.sortedByCoord.out.bam"
	threads: 
		threads_high
	conda:
		"../envs/star.yaml"
	params:
		genome = config['star']['star_genome'],
		date = time.strftime("%Y-%m-%d")
	shell:
		'STAR '
		'--outFileNamePrefix results/bam/{wildcards.sample}/{wildcards.sample}. '
		'--outSAMtype BAM SortedByCoordinate '
		'--quantMode GeneCounts '
		'--outSAMattrRGline ID:{wildcards.sample} SM:{wildcards.sample} LB:{wildcards.sample} DT:{params.date} '
		'--outWigType wiggle '
		'--outWigStrand Unstranded '
		'--outWigNorm RPM '
		'--runThreadN {threads} '
		'--readFilesCommand zcat '
		'--genomeDir {params.genome} '
		'--readFilesIn  {input[0]} {input[1]}'
