# 03. Search(2)

## 1. from / size

- from과 size 필드는 pagination과 비슷

  ```json
  {
      "from" : 0,
      "size" : 3,
      "query" : {
          "match_all" :{}
      }
  }
  ```

## 2. sort

- 특정 필드마다 하나 이사의 정렬을 추가 가능

- sort를 사용하지 않을 경우, 기본 정렬은 `_score` 내림차순(desc)

- 다른 항목을 정렬할 경우 기본으로 오름차순(asc)

  ```json
  // age 기준으로 1차 정렬, balance 기준으로 2차 정렬
  {
      "sort" : [
          {"age" : "desc"},
          {"balance" : "desc"},
          "_score"
      ],
      "query" : {
          "match_all" : {}
      }
  }
  ```

## 3. source filtering

- `_source` 필드를 통해 검색된 데이터에서 특정 필드들만 반환하도록 가능
- document의 총 개수만 알고 싶을 경우, `_source`를 노출시키지 않아 성능 향상가능

```json
// 모든 필드들을 응답받지 않는 쿼리
{
    "_source" : false,
    "query" : {
        "match_all" : {}
    }
}
```

- 특정 필드만 응답 받을 경우

```json
{
    "_source" : ["field1", "field2"],
    "query" : {
        "match_all" :{}
    }
}
```

## 4. aggregations

- aggregations는 집계를 의미하며 document의 통계를 낼 수 있음
- SQL에서 GROUP BY와 유사

  ```json
{
  "query": {
    "term": {
      "address" : "street"
    }
  },
  "aggs" : {
    "avg_balance_test" : {
       "avg" : {
         "field" : "balance"
       }
    }
  }
}
  ```



