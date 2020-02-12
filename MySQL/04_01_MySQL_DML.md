# 04_01_MySQL_DML

## 1. 가져오기(SELECT)

- 특정 열 가져오기

  ```mysql
  SELECT 열이름 FROM 테이블명;
  ```

- 여러 열 가져오기

  ```mysql
  SELECT 열이름1, 열이름2, 열이름3 FROM 테이블명;
  ```

- 모든 열 가져오기

  ```mysql
  SELECT * FROM 테이블명;
  ```

## 2. 정렬하기(ORDER BY)

- 정렬하기 기본

  ```mysql
  SELECT 열 FROM 테이블; 
  ```

- 여러 열로 정렬하기

  ```mysql
  SELECT 열1, 열2, 열3 FROM 테이블 ORDER BY 열1, 열2;
  ```

  - 열이름1로 먼저 정렬한 후 열이름2로 정렬한다.

- 열 위치를 기준으로 정렬하기

  ```mysql
  SELECT 열1, 열2, 열3 FROM 테이블 ORDER BY 2, 3;
  ```

  - 2번째 열로 정렬한 후 3번째 열로 정렬한다.

- 정렬방향 지정하기

  - 오름차순 (기본)

    ```mysql
    SELECT 열1, 열2, 열3 FROM 테이블 ORDER BY 열1;
    ```

  - 내림차순

    ```mysql
    SELECT 열1, 열2, 열3 FROM 테이블 ORDER BY 열1 DESC;
    ```

    - DESC는 바로 앞에 있는 열 이름에만 영향을 주므로 기준이 여러 개일경우 DESC 앞의 기준만 적용된다.

      ```mysql
      SELECT 열1, 열2, 열3 FROM 테이블 ORDER BY 열1 DESC, 열2;
      ```

## 3. 필터링 하기(WHERE)

### 3.1 기본

- WHERE 절 연산자

  |  연산자   |          설 명          |
  | :-------: | :---------------------: |
  |    `=`    |          같음           |
  |   `<>`    |        같지 않음        |
  |   `!=`    |        같지 않음        |
  |    `<`    |        보다 작음        |
  |   `<=`    |    보다 작거나 같음     |
  |   `!<`    |     보다 작지 않음      |
  |    `>`    |         보다 큼         |
  |   `>=`    |    보다 크거나 같음     |
  |   `!>`    |     보다 크지 않음      |
  | `BETWEEN` | 지정된 두값 사이에 있음 |
  | `IS NULL` |        NULL 값임        |

- 한 값을 대상으로 확인

  ```mysql
  SELECT 열1, 열2 FROM 테이블 WHERE 열 = 조건;
  ```

- BETWEEN 사용하기

  ```mysql
  SELECT 열1, 열2 FROM 테이블 WHERE 열1 BETWEEN 값1 AND 값2;
  ```

- 값이 없을 경우를 찾기

  ```mysql
  SELECT 열1, 열2 FROM 테이블 WHERE 열1 IS NULL;
  ```

### 3.2 고급

- AND 연산자 이용

  ```mysql
  SELECT 열1, 열2, 열3 FROM 테이블 WHERE 열1 = 값1 AND 열2 = 값2;
  ```

- OR 연산자 이용

  ```mysql
  SELECT 열1, 열2, 열3 FROM 테이블 WHERE 열1 = 값1 OR 열2 = 값2;
  ```

- 순서를 정하고 싶다면 괄호를 이용

  ```mysql
  SELECT 열1, 열2, 열3 FROM 테이블 WHERE (열1 = 값1 OR 열2 = 값2) AND 열3 = 값3;
  ```

- IN 연산자 활용

  ```mysql
  SELECT 열1, 열2, 열3 FROM 테이블 WHERE 열1 IN (값1, 값2);
  ```

- NOT 연산자 활용

  ```mysql
  SELECT 열1, 열2, 열3 FROM 테이블 WHERE NOT 열1 = 값1;
  ```

### 3.3 와일드 카드

- %(퍼센트) : 위치에 따른 모든 문자

  ```mysql
  SELECT 열1, 열2 FROM 테이블 WHERE 열1 LIKE '값%';
  
  SELECT 열1, 열2 FROM 테이블 WHERE 열1 LIKE '%값';
  
  SELECT 열1, 열2 FROM 테이블 WHERE 열1 LIKE '%값%';
  
  SELECT 열1, 열2 FROM 테이블 WHERE 열1 LIKE '값%값'
  ```

- _(언더바) : 위치에 따른 한 문자

  ```mysql
  SELECT 열1, 열2 FROM 테이블 WHERE 열1 LIKE '값_';
  
  SELECT 열1, 열2 FROM 테이블 WHERE 열1 LIKE '_값';
  
  SELECT 열1, 열2 FROM 테이블 WHERE 열1 LIKE '_값_';
  
  SELECT 열1, 열2 FROM 테이블 WHERE 열1 LIKE '값_값';
  ```

## 4. 그룹화(GROUP BY)

### 4.1 기본

```mysql
SELECT 열1, 열2 FROM 테이블 GROUP BY 열1;
```

### 4.2 그룹화 조건(HAVING)

```mysql
SELECT 열1, COUNT(*) 
FROM 테이블 
WHERE 열2 >= 4 
GROUP BY 열1 
HAVING COUNT(*) >=2;
```

## 5. 순서

|    절    |         설 명          |             필수 여부              |
| :------: | :--------------------: | :--------------------------------: |
|  SELECT  |    반환할 열이나 식    |            반드시 필요             |
|   FROM   | 데이터를 가져올 테이블 | 테이블에서 데이터를 선택할 때 필요 |
|  WHERE   |    행 수준의 필터링    |         필터링이 필요할 때         |
| GROUP BY |       그룹 지정        |         그룹별로 집계할 때         |
|  HAVING  |   그룹 수준의 필터링   |                선택                |
| ORDER BY |      결과를 정렬       |                선택                |

