# 04_02_MySQL_DML

## 1. 계산 필드

- 서로 다른 테이블이나 다른 열을 하나의 열로 만들기

  ```mysql
  SELECT CONCAT(열1, 열2, ...) FROM 테이블;
  ```

- 하나로 합친 열에 별칭을 지정하기

  ```mysql
  SELECT CONCAT(열1, 열2, ...) AS 별칭 FROM 테이블
  ```

- 수학적 계산

  ```mysql
  SELECT 열1 + 열2 AS 합, 열1 - 열2 AS 차, 열1 * 열2 AS 곱, 열1 / 열2 AS 나누기 FROM 테이블;
  ```

## 2. 데이터 조작 함수

### 2.1 텍스트 제어 함수

|   함 수   |                 설 명                  |
| :-------: | :------------------------------------: |
|  LEFT()   |  왼쪽 끝에서부터 지정된 길이만큼 반환  |
|  RIGHT()  | 오른쪽 긑에서부터 지정된 길이만큼 반환 |
| LENGTH()  |          문자열의 길이를 반환          |
|  LOWER()  |         문자열을 소문자로 변경         |
|  UPPER()  |         문자열을 대문자로 변경         |
|  LTRIM()  |       문자열 왼쪽의 공백을 제거        |
|  RTRIM()  |      문자열 오른쪽의 공백을 제거       |
| SOUNDEX() |     문자열을 발음을 기준으로 검색      |

- SOUNDEX() 예시

  ```MYSQL
  SELECT 이름 FROM 테이블 WHERE SOUNDEX(이름) = SOUNDEX('Michael');
  
  # 결과
  이름
  --------
  Michelle
  ```

### 2.2 날짜와 시간 제어 함수

- [Git Hub참고](https://github.com/hasuikhs/SQL/blob/master/MySQL/02_01_Date%26Time.md)

### 2.3 숫자 제어 함수

| 함 수  |         설 명         |
| :----: | :-------------------: |
| ABS()  |  숫자의 절대값 반환   |
| COS()  | 각도의 코사인 값 반환 |
| SIN()  |  각도의 사인 값 반환  |
| TAN()  | 각도의 탄젠트 값 반환 |
| EXP()  |  숫자의 지수 값 반환  |
|  PI()  |     파이 값 반환      |
| SQRT() | 숫자의 제곱근 값 반환 |

### 2.4 집계 함수

- AVG() : 평균 구하기

  ```mysql
  SELECT AVG(열) AS 평균 FROM 테이블;
  ```

- COUNT() : 개수 세기

  ```mysql
  SELECT COUNT(*) FROM 테이블;
  ```

- MAX() : 최대값 구하기

  ```mysql
  SELECT MAX(열) FROM 테이블;
  ```

- MIN() : 최소값 구하기

  ```mysql
  SELECT MIN(열) FROM 테이블;
  ```

- SUM() : 합계 구하기

  ```mysql
  SELECT SUM(열) FROM 테이블;
  ```


## 3. UNION

- 여러 개의 SELECT 문을 하나의 결과 집합으로 표현할 때 사용
- 이때 각각의 SELECT 문으로 선택된 **필드의 개수, 타입, 순서가 같아야 한다**.

### 3.1 기본

- 기본적으로 DISTINCT를 명시하지 않아도 **중복되는 레코드를 제거**한다.

  ```mysql
  SELECT 열 FROM 테이블1
  UNION
  SELECT 열 FROM 테이블2;
  ```

### 3.2 UNION ALL

- 중복된 레코드까지 모두 출력

```mysql
SELECT 열 FROM 테이블1
UNION ALL
SELECT 열 FROM 테이블2;
```

