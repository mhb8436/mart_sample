# Snakemake Shell Command
## using kubernetes
```bash
snakemake --cores all --jobs 8 --default-resources mem_mb=None disk_mb=None --rerun-incomplete --config data_dir=input_folders/TestProject/workflow3/AN10001 outputs_dir=output_folders/TestProject/workflow3/AN10002 resource_dir=resource_folders/TestProject/workflow3 --envvars AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY GITHUB_TOKEN --rerun-incomplete --kubernetes --default-remote-provider S3 --default-remote-prefix mindera-mlops-prod-bucket --container-image 779792627677.dkr.ecr.us-west-2.amazonaws.com/mindera-mlops-prod-snakemake:0.4 --use-conda --use-singularity
```