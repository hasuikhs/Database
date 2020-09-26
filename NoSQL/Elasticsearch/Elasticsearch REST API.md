# Elasticsearch

> REST API로 Elasticsearch 다루기[https://coding-start.tistory.com/172?category=757916](https://coding-start.tistory.com/172?category=757916)

## 1. Document

### 1.1 create

- Document(Schema) 정의

  - **`PUT` 방식**으로 `http://<host>:<port>/_template/<document_name>`

  ```json
  {
      "index_patterns": [ "logger_trend-*" ],
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

- **`PUT` 방식**으로 `http://<host>:<port>/<index>/_doc/<id>`

### 2.2 Read

- LIST 읽기
  - **`GET` 방식**으로 `http://<host>:<port>/<index>/_search`
- 단일 읽기
  - **`GET` 방식**으로 `http://<host>:<port>/<index>/_search/<id>`

### 2.3 Delete

- **`DELETE` 방식**으로 `http://<host>:<port>/<index>/trend/<id>`

