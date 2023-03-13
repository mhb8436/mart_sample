rule count:
	input:
		COUNT_INPUT_FILES, # count 룰을 작업할 때 필요한 입력파일 
		JAR_FILE # count 룰을 실행할 때 java class 가 포함된 jar 파일, 이 파일은 S3에 업로드되어 있어야 한다. 
	output:
		COUNT_FILE # count룰의 작업 결과 파일 
	log:
		COUNT_LOG # count룰의 로그파일 
	conda:
		f'{ENVS_DIR}/count.yaml' # count 룰 실행 시에 jdk등의 도구가 필요한데 해당 jdk를 쿠버네티스 pod에 설치하기 위한 conda 설정파일 
	params:
		jar=S3_PREFIX + '/' + JAR_FILE, # jar 파일의 s3 경로 
		odate=ODATE # YYYYMMDD 형태의 현재 날짜 포멧 
	group: "sample" 
	script:
		COUNT_SCRIPT # count룰 실행을 위한 스크립트 