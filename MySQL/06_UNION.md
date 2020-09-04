# 06_UNION

> UNION 연산자는 여러 테이블에 존재하는 같은 성격의 값을 한 번의 쿼리로 추출할 수 있도록 함

## 6.1 주의점

- 대응하는 필드의 이름이 같아야 한다. 같지 않다면 Alias를 사용하여 맞춰줘야 함
- 대응되는 각 필드의 타입이 같아야 함

### 6.2 사용법

- Member 테이블

| seq  | u_name | u_email        |
| ---- | ------ | -------------- |
| 1    | user1  | user1@test.com |
| 2    | user2  | user2@test.com |
| 3    | user3  | user3@test.com |

- emp 테이블

| emp_seq | emp_name | emp_email        |
| ------- | -------- | ---------------- |
| 1       | user4    | user4@test.co.kr |
| 2       | user5    | user5@test.co.kr |
| 3       | user6    | user6@test.co.kr |

- **중복되지 않은 유일한 정보만 추출하는 경우**

  ```mysql
  (SELECT u_name, u_email FROM Member seq < 10)
  UNION
  (SELECT emp_name AS u_name, emp_email AS  u_email FROM emp where emp_seq < 10)
  ```

- **중복되더라도 모든 값을 추출하는 경우**

  - UNION에 ALL을 붙여줌

  ```mysql
  (SELECT u_name, u_email FROM Member seq < 10)
  UNION ALL
  (SELECT emp_name AS u_name, emp_email AS  u_email FROM emp where emp_seq < 10)
  ```

- **정렬이 필요한 경우**

  - 쿼리의 끝에 정렬을 추가

  ```mysql
  (SELECT u_name, u_email FROM Member seq < 10)
  UNION ALL
  (SELECT emp_name AS u_name, emp_email AS  u_email FROM emp where emp_seq < 10)
  ORDER BY u_name
  ```

  