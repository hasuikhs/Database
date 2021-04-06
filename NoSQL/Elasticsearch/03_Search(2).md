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
  
## 5. 실습

- `page_url`을 기준으로 aggregation하고 `unique_pageview`를 합치고, 각 `page_url`의 합친 `unique_pageview`의 최종 합계를 구하라

  ```json
  {
      "query": {
          "bool": {
              "filter": [
                  {
                      "terms": {
                          "pfno": [
                              "87896"
                          ],
                          "boost": 1.0
                      }
                  },
                  {
                      "range": {
                          "statdate": {
                              "from": "2020-08-31T15:00:00Z",
                              "to": "2020-09-30T14:59:59Z",
                              "include_lower": true,
                              "include_upper": true,
                              "boost": 1.0
                          }
                      }
                  },
                  {
                      "terms": {
                          "is_last_page": [
                              "Y"
                          ],
                          "boost": 1.0
                      }
                  }
              ],
              "adjust_pure_negative": true,
              "boost": 1.0
          }
      },
      "aggregations": {
          "by_page": {
              "terms": {
                  "field": "page_url",
                  "missing": 0,
                  "size": 10,
                  "min_doc_count": 1,
                  "shard_min_doc_count": 0,
                  "show_term_doc_count_error": false,
                  "order": [
                      {
                          "_count": "desc"
                      },
                      {
                          "_key": "asc"
                      }
                  ]
              },
              "aggregations": {
                  "page_title": {
                      "terms": {
                          "field": "page_title",
                          "missing": "",
                          "size": 10,
                          "min_doc_count": 1,
                          "shard_min_doc_count": 0,
                          "show_term_doc_count_error": false,
                          "order": [
                              {
                                  "_count": "desc"
                              },
                              {
                                  "_key": "asc"
                              }
                          ]
                      }
                  },
                  "unique_pageview": {
                      "sum": {
                          "field": "unique_pageview",
                          "missing": 0
                      }
                  },
                  "sort": {
                      "bucket_sort": {
                          "sort": [
                              {
                                  "unique_pageview": {
                                      "order": "desc"
                                  }
                              }
                          ],
                          "from": 0,
                          "gap_policy": "SKIP"
                      }
                  }
              }
          },
          "sum_unique_pageview": {
              "sum_bucket": {
                  "buckets_path": [
                      "by_page>unique_pageview"
                  ],
                  "gap_policy": "skip"
              }
          }
      }
  }
  ```

  - java code

  ```java
  List<FieldSortBuilder> sorts = new ArrayList<FieldSortBuilder>();
  FieldSortBuilder pageviewsort = new FieldSortBuilder("unique_pageview").order(SortOrder.DESC);
  sorts.add(pageviewsort);
  		
  SearchResponse searchResponse = null;
  SearchSourceBuilder sourceBuilder = new SearchSourceBuilder();
  sourceBuilder
  	.query(QueryBuilders
  		.boolQuery()
  		.filter(QueryBuilders
  			.termsQuery("pfno", ctsProfilesList)
  		)
  		.filter(QueryBuilders
  			.rangeQuery("statdate")
  				.gte(statDatePs)
  				.lte(statDatePe)
  		)
  		.filter(QueryBuilders
  			.termsQuery("is_first_page", "Y")
  		)	
  	)
  	.aggregation(AggregationBuilders
  		.terms("by_page")
  		.field("page_url")
  		.missing(0)
  				
  		.subAggregation(AggregationBuilders
  			.terms("page_title")
  			.field("page_title")
  			.missing(""))
  				
  		.subAggregation(AggregationBuilders
  			.sum("unique_pageview")
  			.field("unique_pageview")
  			.missing(0))
  				
          // aggregation 된 결과로 sort
  		.subAggregation(PipelineAggregatorBuilders
      	    .bucketSort("sort", sorts))
  		)
          // aggregation 된 결과들을 합침
  	.aggregation(PipelineAggregatorBuilders
      	.sumBucket("sum_unique_pageview", "by_page>unique_pageview"))
  ;
  ```

- 지정하는 날짜들의 데이터들에서 시간대별로 page 뷰를 구하고, 한국 표준시(KST)로 지정하라

  ```json
  {
      "query": {
          "bool": {
              "filter": [
                  {
                      "terms": {
                          "pfno": [
                              "24853"
                          ],
                          "boost": 1.0
                      }
                  },
                  {
                      "range": {
                          "statdate": {
                              "from": "2020-08-31T15:00:00Z",
                              "to": "2020-09-30T14:59:59Z",
                              "include_lower": true,
                              "include_upper": true,
                              "boost": 1.0
                          }
                      }
                  }
              ],
              "adjust_pure_negative": true,
              "boost": 1.0
          }
      },
      "sort": [
          {
              "statdate": {
                  "order": "asc"
              }
          }
      ],
      "aggregations": {
          "by_hour": {
              "terms": {
                  "script": {
                      "source": "Instant.ofEpochMilli(doc['statdate'].value.toInstant().toEpochMilli()).atZone(ZoneId.of(params.tz)).hour",
                      "lang": "painless",
                      "params": {
                          "tz": "Asia/Seoul"
                      }
                  },
                  "size": 10,
                  "min_doc_count": 0,
                  "shard_min_doc_count": 0,
                  "show_term_doc_count_error": false,
                  "order": [
                      {
                          "_count": "desc"
                      },
                      {
                          "_key": "asc"
                      }
                  ]
              },
              "aggregations": {
                  "avg_pageview": {
                      "avg": {
                          "field": "pageview",
                          "missing": 0
                      }
                  },
                  "avg_visit": {
                      "avg": {
                          "field": "visit",
                          "missing": 0
                      }
                  }
              }
          },
          "sum_avg_pageview": {
              "sum_bucket": {
                  "buckets_path": [
                      "by_hour>avg_pageview"
                  ],
                  "gap_policy": "skip"
              }
          },
          "sum_avg_visit": {
              "sum_bucket": {
                  "buckets_path": [
                      "by_hour>avg_visit"
                  ],
                  "gap_policy": "skip"
              }
          }
      }
  }
  ```

  - java code

  ```java
  Map<String, Object> params = new HashMap<String, Object>();
  params.put("tz", "Asia/Seoul");
  		
  sourceBuilder
  	.query(QueryBuilders
  		.boolQuery()
  		.filter(QueryBuilders
  			.termsQuery("pfno", ctsProfilesList)
  		)
  		.filter(QueryBuilders
  			.rangeQuery("statdate")
  				.gte(statDatePs)
  				.lte(statDatePe)
  		)
  	)
  	.sort(SortBuilders.fieldSort("statdate"))
  			
  	.aggregation(AggregationBuilders
  		.terms("by_hour")
  			.script(new Script(ScriptType.INLINE, "painless", "Instant.ofEpochMilli(doc['statdate'].value.toInstant().toEpochMilli()).atZone(ZoneId.of(params.tz)).hour", params))
              // 요일은 dayOfWeek로 변환
  			.minDocCount(0)
  					
  			.subAggregation(AggregationBuilders
  				.avg("avg_pageview")
  					.field("pageview")
  					.missing(0))
  					
  			.subAggregation(AggregationBuilders
  				.avg("avg_visit")
  					.field("visit")
  					.missing(0))
  		)
  	.aggregation(PipelineAggregatorBuilders
      	.sumBucket("sum_avg_pageview", "by_hour>avg_pageview"))
  	.aggregation(PipelineAggregatorBuilders
          .sumBucket("sum_avg_visit", "by_hour>avg_visit"))
  ;
  ```
  
  - sort기능과 검색기능을 추가하는데, 검색은 page_title 또는 page_url에서 같은 키워드로 검색한 데이터를 가져오면서, aggregation 된 pageview를 unique_pageview로 나눈값을 추가하고, pageview와 unique_pageview의 총 합을 구하라
  
  ```json
  {
  	"query": {
      	"bool": {
          	"filter": [
              	{
                  	"terms": {
                      	"pfno": [
                                "87896"
                            ],
                            "boost": 1.0
                        }
                    },
                    {
                        "range": {
                            "statdate": {
                                "from": "2020-08-31T15:00:00Z",
                                "to": "2020-09-30T14:59:59Z",
                                "include_lower": true,
                                "include_upper": true,
                                "boost": 1.0
                            }
                        }
                    },
                    {
                        "bool": {
                            "should": [
                                {
                                    "wildcard": {
                                        "page_title": {
                                            "wildcard": "*biz*",
                                            "boost": 1.0
                                        }
                                    }
                                },
                                {
                                    "wildcard": {
                                        "page_url": {
                                            "wildcard": "*biz*",
                                            "boost": 1.0
                                        }
                                    }
                                }
                            ],
                            "adjust_pure_negative": true,
                            "boost": 1.0
                        }
                    }
                ],
                "adjust_pure_negative": true,
                "boost": 1.0
            }
        },
        "aggregations": {
            "by_page": {
                "terms": {
                    "field": "page_url",
                    "missing": 0,
                    "size": 10,
                    "min_doc_count": 1,
                    "shard_min_doc_count": 0,
                    "show_term_doc_count_error": false,
                    "order": [
                        {
                            "_count": "desc"
                        },
                        {
                            "_key": "asc"
                        }
                    ]
                },
                "aggregations": {
                    "page_title": {
                        "terms": {
                            "field": "page_title",
                            "missing": "",
                            "size": 10,
                            "min_doc_count": 1,
                            "shard_min_doc_count": 0,
                            "show_term_doc_count_error": false,
                            "order": [
                                {
                                    "_count": "desc"
                                },
                                {
                                    "_key": "asc"
                                }
                            ]
                        }
                    },
                    "pageview": {
                        "sum": {
                            "field": "pageview",
                            "missing": 0
                        }
                    },
                    "unique_pageview": {
                        "sum": {
                            "field": "unique_pageview",
                            "missing": 0
                        }
                    },
                    "pageview_per_unique_pageview": {
                        "bucket_script": {
                            "buckets_path": {
                                "unique_pageview": "unique_pageview",
                                "pageview": "pageview"
                            },
                            "script": {
                                "source": "params.pageview / params.unique_pageview",
                                "lang": "painless"
                            },
                            "gap_policy": "skip"
                        }
                    },
                    "sort": {
                        "bucket_sort": {
                            "sort": [
                                {
                                    "pageview": {
                                        "order": "desc"
                                    }
                                }
                            ],
                            "from": 0,
                            "gap_policy": "SKIP"
                        }
                    }
                }
            },
            "sum_pageview": {
                "sum_bucket": {
                    "buckets_path": [
                        "by_page>pageview"
                    ],
                    "gap_policy": "skip"
                }
            },
            "sum_unique_pageview": {
                "sum_bucket": {
                    "buckets_path": [
                        "by_page>unique_pageview"
                    ],
                    "gap_policy": "skip"
                }
            }
        }
    }
  ```
  - java code

  ```java
sourceBuilder
  	.query(QueryBuilders
      	.boolQuery()
  		.filter(QueryBuilders
  			.termsQuery("pfno", ctsProfilesList)
  		)
  		.filter(QueryBuilders
  			.rangeQuery("statdate")
  				.gte(statDatePs)
  				.lte(statDatePe)
  		)
  		.filter(QueryBuilders
  			.boolQuery()
  			.should(QueryBuilders.wildcardQuery("page_title", '*' + searchWord + '*'))
  			.should(QueryBuilders.wildcardQuery("page_url", '*' + searchWord + '*'))
  		)
  	)
  	.aggregation(AggregationBuilders
  		.terms("by_page")
  		.field("page_url")
  		.missing(0)
  				
  		.subAggregation(AggregationBuilders
  			.terms("page_title")
  			.field("page_title")
  			.missing(""))
  				
  		.subAggregation(AggregationBuilders
  			.sum("pageview")
  			.field("pageview")
  			.missing(0))
  				
  		.subAggregation(AggregationBuilders
  			.sum("unique_pageview")
  			.field("unique_pageview")
  			.missing(0))
  				
  		.subAggregation(PipelineAggregatorBuilders
  			.bucketScript(
  				"pageview_per_unique_pageview",
  				new HashMap<String, String>() {
  					{
  						put("pageview", "pageview");
  						put("unique_pageview", "unique_pageview");
  					}
  				}, 
  				new Script("params.pageview / params.unique_pageview")
  			)
          )
  				
  		.subAggregation(PipelineAggregatorBuilders
  			.bucketSort("sort", sorts))
  		)
  			
  	.aggregation(PipelineAggregatorBuilders
  		.sumBucket("sum_pageview", "by_page>pageview"))
  			
  	.aggregation(PipelineAggregatorBuilders
  		.sumBucket("sum_unique_pageview", "by_page>unique_pageview"))
  ;
  ```

- bucketScript는 bucket을 대상으로 하는 쿼리이므로, 제일 상단의 aggregation의 계산을 할 수는 없다.

  (위 코드에서는 55 ~ 59 줄의 aggregation의 나누기 등의 계산)

  - bucketScript를 이용해서 나누기 등 계산시 분모가 0일 경우, 계산이 될 수 없지만 결과에는 null 값이 들어오게 되므로 결과 처리시 주의

- java에서 Pipeline 계산된 값은 ParsedSimpleValue로 캐스팅해서 사용
  
  - 값이 없을 경우 null 예외가 발생하므로 주의
  
- java에서 동적으로 쿼리를 만들시 ParsedBucket을 받아 쓸 때 ParsedDateHistogram.ParsedBucket, ParsedTerms.ParsedBucket 등의 자료형으로 나눠질 수 있어 쿼리가 깔끔하지 않을 수도 있는데 그 상위 클래스인 ParsedMultiBucketAggregation.ParsedBucket으로 받아 사용 가능

- 시간을 기준으로 aggregation할 때 키값에 시간대가 담기게 되는데 이 키값이 "0", "1", ..., "23" 이 문자열형식으로 들어가므로 sort가 원하는데로 되지 않으므로, 정렬은 서버 쪽에서 따로 해주도록 함

- java코드에서 bucket들을 정렬해야할 때, 기본 필드를 정렬할 때와 Pipeline 계산된 필드의 이름을 기준으로 정렬을 할 때 차이가 있다.

  ```java
  // 기본 필드로 정렬할 때
  // aggregation에서
  .aggregation(AggregationBuilders
      .terms("by_page")
  	.field("page_url")
      .order(BucketOrder.compound(
          // pipline 계산 필드의 이름을 넣으면 검색 결과가 null로 반환
         	BucketOrder.aggregation("field_name", true)	// true면 asc, false면 desc
       ))
  	.missing(0)
               
  // pipeline 집계된 필드까지 정렬할 때는
  .subAggregation(PipelineAggregatorBuilders
  	.bucketSort(
          "sort",
          new ArrayList<FieldSortBuilder>(){{
              add(new FieldSortBuilder("field_name").order(SortOrder.DESC)) // asc는 SortOrder.ASC
          }}
      )
  )
  ```

  