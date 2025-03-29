# Snakemake 워크플로우 문서

## 개요
이 저장소는 Kubernetes 환경에서 데이터 처리 작업을 실행하기 위한 Snakemake 워크플로우 설정을 포함하고 있습니다. 이 워크플로우는 분산 환경에서 Java 기반의 데이터 처리 작업을 실행하도록 설계되었습니다.

## 사전 요구사항
- Snakemake
- Kubernetes 클러스터 접근 권한
- AWS S3 접근 권한
- Docker/Singularity
- Conda

## 설정

### 환경 변수
다음 환경 변수들이 필요합니다:
- `AWS_ACCESS_KEY_ID`: AWS 접근 키 ID
- `AWS_SECRET_ACCESS_KEY`: AWS 비밀 접근 키
- `GITHUB_TOKEN`: GitHub 인증 토큰
- `s3bucktname_prod`: S3 버킷 이름
- `dbhost`: 데이터베이스 호스트
- `dbport`: 데이터베이스 포트
- `database`: 데이터베이스 이름
- `dbuser`: 데이터베이스 사용자
- `dbpassword`: 데이터베이스 비밀번호

### 리소스 설정
- 기본 리소스는 무제한으로 설정되어 있습니다:
  - 메모리: `mem_mb=None`
  - 디스크: `disk_mb=None`

## 워크플로우 실행

### Kubernetes 실행 명령어
```bash
snakemake \
    --cores all \
    --jobs 8 \
    --default-resources mem_mb=None disk_mb=None \
    --rerun-incomplete \
    --config \
        out_prefix=20230314080919 \
        data_dir=input_folders/TestProject/workflow3/AN10001 \
        outputs_dir=output_folders/TestProject/workflow3/AN10002 \
        resources_dir=resource_folders/TestProject/workflow3 \
    --envvars \
        AWS_ACCESS_KEY_ID \
        AWS_SECRET_ACCESS_KEY \
        GITHUB_TOKEN \
        s3bucktname_prod \
        dbhost \
        dbport \
        database \
        dbuser \
        dbpassword \
    --rerun-incomplete \
    --kubernetes \
    --default-remote-provider S3 \
    --default-remote-prefix mindera-mlops-prod-bucket \
    --container-image 779792627677.dkr.ecr.us-west-2.amazonaws.com/mindera-mlops-prod-snakemake:0.4 \
    --use-conda \
    --use-singularity
```

## 워크플로우 구성 요소

### Java 처리 스크립트 (run.sh)
워크플로우에는 데이터 처리 작업을 실행하는 Java 스크립트가 포함되어 있습니다.

```bash
java -jar "${snakemake_params[jar]}" "${snakemake_input[0]}" "${snakemake_params[odate]}" > "${snakemake_output[0]}"
```

### Snakemake 규칙 매핑
워크플로우는 다음과 같은 규칙 구조를 사용합니다:

```yaml
rules/count.smk:
  input:
    - COUNT_INPUT_FILES  # snakemake_input[0]로 매핑
    - JAR_FILE
  output:
    - COUNT_FILE        # snakemake_output[0]로 매핑
  params:
    jar: S3_PREFIX + '/' + JAR_FILE  # snakemake_params[jar]로 매핑
    odate: ODATE                     # snakemake_params[odate]로 매핑
```

## 추가 정보
이 워크플로우에 대한 자세한 정보는 MLOps 사이트의 464번 워크플로우를 참조하시기 바랍니다. 