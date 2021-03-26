# WITH

- SQL에서 서브쿼리를 사용할 때는 새로운 테이블이 생성되는데, 같은 **서브 쿼리를 계속 사용한다면 메모리 문제 발생 가능**
- **WITH 구문을 이용하여 임시 테이블을 미리 만들어두고 계속 사용 가능**

```mysql
WITH 임시 테이블 이름 as (쿼리)
```

```mysql
WITH tmp_tb AS (
	SELECT 컬럼1, 컬럼2, ...
    FROM 테이블
)
SELECT 컬럼1, 컬럼2, ... FROM tmp_tb;
```

