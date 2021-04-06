# Elasticsearch

> REST API로 Elasticsearch 다루기[https://coding-start.tistory.com/172?category=757916](https://coding-start.tistory.com/172?category=757916)

## 1. Document

### 1.1 create

- Document(Schema) 정의

  - **`PUT` 방식**으로 `http://<host>:<port>/_template/<document_name>`

  ```json
  {
      "index_patterns": [ "index_name-*" ],
      "settings" : {
          "number_of_shards" : 3,
          "number_of_replicas" : 2
      },
      "mappings": {
          "trend": {
              "properties": {
                  /* dimensions */
                  "pfno": { "type": "keyword" },          /* 서비스번호 */
                  "statdate": { "type": "date" },         /* 일시 YYYY-MM-DD HH:00:00 */
                  "is_mobile": { "type": "keyword" },     /* 모바일 여부 ('Y', 'N') */
                  "sex": { "type": "keyword" },           /* 성별 */
                  "age": { "type": "keyword" },           /* 연령대 or 회원특성코드 */
  
                  /* metrics */
                  ...
              }
          }
      }
  }
  ```


### 1.2 remove

- **`DELETE` 방식**으로 `http://<host>:<port>/_template/<document_id>`

## 2. Data

### 2.1 Insert

- **`PUT` 방식**으로 `http://<host>:<port>/<index>/<type>/<id>`
- **`POST`** 방식으로 `http://<host>:<port>/<index>/<type>`
  - POST 방식으로 넣을 때는 별도의 id를 입력하지 않아도, id를 난수값들로 만들어서 저장

### 2.2 Read

- LIST 읽기
  
  - **`GET` 방식**으로 `http://<host>:<port>/<index>/_search`
  
- 단일 읽기
  
  - **`GET` 방식**으로 `http://<host>:<port>/<index>/_search/<id>`
  
- Response 분석

  ```json
  {
      "took" : 23,
      "time_out" : false,
      "_shards": {
          "total" :5,
          "successful" : 5,
          "skipped" : 0,
          "failed" : 0
      },
      "hits" : {
          "total" : 60,
          "max_score" : 1.0,
          "hits" : [
              {
                  "_index" : "bank",
                  "_type" : "account",
                  "_id" : "25",
                  "_score" : 1.0,
                  "_source" : {
                      ...
                  }
              }
          ]
      }
  }
  ```

  - **`took`** : 검색하는데 걸린 시간 (ms)
  - **`timed_out`** : 검색시 시간 초과 여부
  - **`_shards`** : 검색한 shard 수 및 검색에 성공 또는 실패한 shard의 수
  - **`hits`** : 검색 결과
    - **`total`** : 검색 조건과 일치하는 문서의 총 개수
    - **`max_score`** : 검색 조건과 결과 일치 수준의 최대값
    - **`hits`** : 검색 결과에 해당하는 실제 데이터들(기본 값으로 10개가 설정되며, size를 통해 조절 가능)
      - **`_score`** : 해당 document가 지정된 검색쿼리와 얼마나 일치하는지를 상대적으로 나타내는 숫자, 높을수록 관련성이 높음
    - **`sort`** : 결과 정렬 방식을 말하며, 기본 정렬 순서는 `_score` 내림차순(desc)이고, 다른 항목일 경우 오름차순(asc)으로 기본 설정 됨(`_score` 기준일 경우 노출되지 않음)

### 2.3 Delete

- **`DELETE` 방식**으로 `http://<host>:<port>/<index>/trend/<id>`

