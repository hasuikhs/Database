# 01. ELK 설치 (Windows 10)

## 1. Elasticsearch 설치

- [https://www.elastic.co/kr/downloads/elasticsearch](https://www.elastic.co/kr/downloads/elasticsearch)에서 WINDOWS 버전 ZIP 파일 다운로드

- 압축파일 해제 - bin - elasticsearch.bat 실행

- localhost:9200 접속 후 확인

  ![image-20201001221906320](01_ELK_설치.assets/image-20201001221906320.png)

## 2. Logstash 설치

- [https://www.elastic.co/kr/downloads/logstash](https://www.elastic.co/kr/downloads/logstash)에서 ZIP 파일 다운로드

- Elasticsearch를 실행하고 해당 경로를 cmd로 열고 아래 명령어 입력

  ```bash
  $ .\bin\logstash.bat -f .\config\logstash-sample.conf
  ```

  

  