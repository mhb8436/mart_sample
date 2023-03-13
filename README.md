# Snakemake Shell Command
## using kubernetes 
```bash
snakemake --cores all --jobs 8 --default-resources mem_mb=None disk_mb=None --rerun-incomplete --config out_prefix=20230314080919 data_dir=input_folders/TestProject/workflow3/AN10001 outputs_dir=output_folders/TestProject/workflow3/AN10002 resources_dir=resource_folders/TestProject/workflow3 --envvars AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY GITHUB_TOKEN s3bucktname_prod dbhost dbport database dbuser dbpassword --rerun-incomplete --kubernetes --default-remote-provider S3 --default-remote-prefix mindera-mlops-prod-bucket --container-image 779792627677.dkr.ecr.us-west-2.amazonaws.com/mindera-mlops-prod-snakemake:0.4 --use-conda --use-singularity
```
자세한 command는 mlops 사이트의 464 번 워크플로우 참조.


## run.sh 설명
```bash
java -jar "${snakemake_params[jar]}" "${snakemake_input[0]}" "${snakemake_params[odate]}" > "${snakemake_output[0]}"
```

|rules/count.smk 중 |
|	input:|
|		COUNT_INPUT_FILES, ==> snakemake_input[0]|
|		JAR_FILE|
|	output:|
|		COUNT_FILE ==> snakemake_output[0]|
|params:|
|    jar=S3_PREFIX + '/' + JAR_FILE,  ==> snakemake_params[jar]|
|    odate=ODATE  ==> snakemake_params[odate]|
| --- |
