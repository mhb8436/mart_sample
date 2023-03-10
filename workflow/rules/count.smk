rule count:
	input:
		COUNT_INPUT_FILES,
		JAR_FILE
	output:
		COUNT_FILE
	conda:
		f'{ENVS_DIR}/count.yaml'
	params:
		jar=S3_PREFIX + '/' + JAR_FILE
	group: "sample"
	script:
		COUNT_SCRIPT