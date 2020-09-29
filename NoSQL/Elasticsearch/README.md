# Elasticsearh ?

- Elasticsearch는 Apache Lucene 기반의 Java 오픈소스 분산 검색 엔진

- 방대한 양의 데이터를 신속하게, 거의 실시간(NRT, Near Real Time)으로 저장, 검색, 분석 가능

- Elasticsearch는 검색을 위해 단독으로 사용되기도 하며, **ELK( Elasticsearch / Logstash / Kibana ) Stack**으로 사용 가능

  - Logstash : 다양한 소스(DB, CSV 파일 등)의 로그 또는 트랜젝션 데이터를 수집, 집계, 파싱하여 Elasticsearch로 전달
  - Elasticsearch : Logstash로부터 받은 데이터를 검색 및 집계를 하여 필요한 관심 있는 정보를 획득
  - Kibana : Elasticsearch의 빠른 검색을 통해 데이터를 시각화 및 모니터링

  ![image-20200929233143673](README.assets/image-20200929233143673.png)

## 0. 비교

| Elasticsearch | Relation DB |
| :-----------: | :---------: |
|     Index     |  Database   |
|     Type      |    Table    |
|   Document    |     Row     |
|     Field     |   Column    |
|    Mapping    |   Schema    |

## 1. 활용처

- 애플리케이션 검색
- 웹사이트 검색
- 엔터프라이즈 검색
- 로깅과 로그 분석
- 인프라 메트릭과 컨테이너 모니터링
- 애플리케이션 성능 모니터링
- 위치 기반 정보 데이터 분석 및 시각화
- 보안 분석
- 비즈니스 분석

## 2. 작동

- 로그, 시스템 메트릭, 웹 애플리케이션 등 다양한 소스로부터 원시 데이터
- 데이터 수집은 원시 데이터가 Elasticsearch에서 색인되기 전에 구문 분석, 정규화, 강화되는 프로세스
- Elasticsearch에서 일단 색인되면, 사용자는 이 데이터에 대해 복잡한 쿼리를 실행하고 집계를 사용해 데이터의 복잡한 요약을 검색 가능
- Kibana에서 사용자는 데이터를 강력하게 시각화하고, 대시보드를 공유하며, Elastic Stack을 관리 가능

## 3. 사용 이유

- Lucene을 기반으로 구축되기 때문에, 전체 텍스트 검색에 뛰어남. Elasticsearch는 또한 거의 실시간 검색 가능
- 문서가 색인될 때부터 검색 가능해질 때까지의 대기 시간이 보통 1초로, Elasticsearch는 보안 분석, 인프라 모니터링 같은 시간이 중요한 사용 사례에 이상적
- Elasticsearch에 저장된 문서는 샤드라고 하는 여러 다른 컨테이너에 걸쳐 분산되며, 이 샤드는 복제되어 하드웨어 장애 시에 중복되는 데이터 사본을 제공
- Elasticsearch의 분산적인 특징은 수백 개(심지어 수천 개)의 서버까지 확장하고 페타바이트의 데이터를 처리 가능
- 속도, 확장성, 복원력뿐 아니라, Elasticsearch에는 데이터 롤업, 인덱스 수명 주기 관리 등과 같이 데이터를 훨씬 더 효율적으로 저장하고 검색할 수 있게 해주는 강력한 기본 기능이 다수 탑재
- Beats와 Logstash의 통합은 Elasticsearch로 색인하기 전에 데이터를 훨씬 더 쉽게 처리 가능
- Kibana는 Elasticsearch 데이터의 실시간 시각화를 제공하며, UI를 통해 애플리케이션 성능 모니터링(APM), 로그, 인프라 메트릭 데이터에 신속하게 접근 가능