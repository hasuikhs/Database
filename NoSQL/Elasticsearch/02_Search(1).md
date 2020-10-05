# 02. Search(1)

## 1. match_all / match_none

- match_all 쿼리는 지정된 index의 모든 document를 검색하는 방법

  - 특별한 검색어 없이 모든 document를 가져오고 싶을 때 사용
  - SQL의 WHERE 절이 없는 SELECT 문

- match_none 쿼리는 모든 document를 가져오고 싶지 않을 때 사용

  ```json
  {
      "query" : {
          "match_all" : {}
      }
  }
  ```

## 2. match

- match 쿼리는 기본 필드 검색 쿼리로 텍스트/숫자/날짜를 허용

  ```json
  {
      "query" : {
          "match" : {
              "address" : "mill"	// address에 mill이 포함되는 모든 document 조회
          }
      }
  }
  ```

## 3. bool

- bool 쿼리는 bool(true / false) 로지글 사용하는 쿼리

  - `must` : bool must 절에 지정된 모든 쿼리가 일치하는 document 조회
  - `should` : bool should 절에 지정된 모든 쿼리 중 하나라도 일치하는 document 조회
  - `must_not` : bool must_not 절에 지정된 모든 쿼리가 일치하지 않는 document 조회
  - `filter` : must와 같이 filter 절에 지저왼 모든 쿼리가 일치하는 document 조회하지만, Filter context에서 실행되기 때문에 score를 무시

- bool 쿼리 내에 위의 각 절들을 조합해서 사용 가능하고, bool 절 내에 bool 쿼리를 작성 가능

  ```json
  // 나이가 30세이지만, seoul에 살고 있지 않은 document를 조회
  {
      "query" : {
          "bool" : {
              "must" : [
                  {
                      "match" : {
                          "age" : "30"
                      }
                  }
              ],
              "must_not" : [
                  {
                      "match" : {
                          "address" : "seoul"
                      }
                  }
              ]
          }
      }
  }
  ```

## 4. filter

- filter 쿼리는 document가 검색 쿼리와 일치하는지 나타내는 `_score` 값을 계산하지 않도록 쿼리 실행을 최적화

## 5. range

- range 쿼리는 범위를 지정하여 범위에 해당하는 값을 갖는 document 조회
  - `gte` : 크거나 같음
  - `gt` : 보다 큼
  - `lte` : 작거나 같음
  - `lt`: 보다 작음

```json
// 잔액이 20000 ~ 30000인 범위에 속하는 모든 document 조회 쿼리
{
    "query" : {
        "bool" : {
            "must" : { "match_all" : {} },
            "filter" : {
                "range" : {
                    "balance" : {
                        "gte" : 20000,
                        "lte" : 30000
                    }
                }
            }
        }
    }
}
```

## 6. term

- term 쿼리는 역색인에 명시된 토큰 중 정확한 키워드가 포함된 document를 조회
- term 쿼리를 사용할 때 document가 조회되지 않는 이슈 발생 가능
  - string 필드는 text 타입 또는 keyword 타입을 갖음
  - **text 타입은 ES 분석기를 통해 역색인이 되는 반면, keyword 타입은 역색인이 되지 않음**
    - 예를 들어 "Quick  Foxes" 라는 문자열이 있을 때 text 타입은 [ quick, foxes ]으로 역색인
    - 이 상황에서 term 쿼리로 "quick" 문자열을 검새갰다면 해당 document를 찾을수 있지만, "quick foxes"라는 full text로 검색했을 경우에는 document를 찾을 수 없음
    - **따라서 term 커리는 정확한 키워드를 찾기 때문에 full text 검색에는 어울리지 않음**
    - **full text 검색을 하고자 할 경우에는 match 쿼리를 사용**
    - term 쿼리로 full text 검색을 하고자 할때는 필드 타입을 keyword 타입으로 해도 됨
- ES에서 분석기를 거쳐 역색인이 될 때 lowercase 처리하기 때문에, uppercase 문자는 찾을 수 없음

## 7. terms

- terms 쿼리는 배열에 나열된 키워드 중 하나와 일치하는 document를 조회

  ```json
  {
      "query" : {
          "terms" : {
              "address" : [
                  "street", "place", "avenue"
              ]
          }
      }
  }
  ```

  
