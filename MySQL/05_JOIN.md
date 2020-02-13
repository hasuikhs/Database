# 05_JOIN

> JOIN 연산은 여러 **테이블을 결합하는 연산**이다. 각 테이블은 각자에 맞는 데이터를 저장하고 있는데, 서로 다른 테이블에서 데이터를 가져오려면 JOIN 연산을 해야한다.

![img](05_JOIN.assets/Visual_SQL_JOINS_V2.png)

- people 테이블

  | name |    phone    | pid  |
  | :--: | :---------: | :--: |
  | 철수 | 01012345678 |  1   |
  | 영희 | 01056781234 |  2   |
  | 민수 | 01098765432 |  3   |

- property 테이블

  | spid | pid  | selling |
  | :--: | :--: | :-----: |
  |  1   |  1   |   집1   |
  |  2   |  3   |   집2   |
  |  3   |  3   |   집3   |
  |  4   |  3   |   집4   |
  |  5   |  4   |   집5   |

## 1. Inner Join

- Inner Join은 기본적으로 교집합이다.

- 간략히 Join으로 나타내는데 ON 뒤는 조건을 지정할 수 있다.

  ```mysql
  SELECT name, phone, selling 
  FROM people 
  JOIN property 
  ON people.pid = property.pid;
  ```

  ```
  +------+-------------+---------+
  | name | phone       | selling |
  +------+-------------+---------+
  | 철수 | 01012345678 | 집1     |
  | 민수 | 01087654321 | 집2     |
  | 민수 | 01087654321 | 집3     |
  | 민수 | 01087654321 | 집4     |
  +------+-------------+---------+
  ```

## 2. Left Join

- 왼쪽 테이블을 중심으로 오른쪽의 테이블을 합친다.

  ```mysql
  SELECT name, phone, selling 
  FROM people 
  LEFT JOIN property 
  ON people.pid = property.pid;
  ```

  ```
  +------+-------------+---------+
  | name | phone       | selling |
  +------+-------------+---------+
  | 철수 | 01012345678 | 집1     |
  | 민수 | 01087654321 | 집2     |
  | 민수 | 01087654321 | 집3     |
  | 민수 | 01087654321 | 집4     |
  | 영희 | 01056781234 | NULL    |
  +------+-------------+---------+
  ```

## 3. Right Join

- 오른쪽 테이블을 중심으로 왼쪽의 테이블을 합친다.

  ```mysql
  SELECT name, phone, selling
  FROM people
  RIGHT JOIN property
  ON people.pid = property.pid;
  ```

  ```
  +------+-------------+---------+
  | name | phone       | selling |
  +------+-------------+---------+
  | 철수 | 01012345678 | 집1     |
  | 민수 | 01087654321 | 집2     |
  | 민수 | 01087654321 | 집3     |
  | 민수 | 01087654321 | 집4     |
  | NULL | NULL        | 집5     |
  +------+-------------+---------+
  ```





