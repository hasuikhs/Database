# 02_MySQL_DDL

## 1. DataBase 관련 명령어

### 1.1 보기

```mysql
SHOW databases;
```

### 1.2 생성

```mysql
CREATE database 데이터베이스명;
```

### 1.3 사용

- DataBase 사용 선언

  ```mysql
  USE 데이터베이스명;
  ```

- 사용 중인 Database 확인

  ```mysql
  select database();
  ```

### 1.4 삭제

```mysql
DROP database 데이터베이스명;
```

## 2. Table 관련 명령어

### 2.1 생성

```mysql
CREATE TABLE 테이블명(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,	# 자동 숫자 증가, 기본키 부여
    name VARCHAR(10) NOT NULL,
    ...
)
```

- 컬럼명을 명시하는 괄호() 안에는 **필드명 / 자료형 / 제약조건 의 형식**을 갖는다.

- **필드명은 일반적으로 snake_case**를 사용

- **자료형**

  |     타 입     |    설 명     |
  | :-----------: | :----------: |
  |      INT      |     정수     |
  |    DOUBLE     |     실수     |
  | VARCHAR(정수) | 문자열(길이) |
  |     DATE      |  YYYY-MM-DD  |
  |     TIME      |   HH:MM:SS   |

- **제약 조건**

  |     조 건      |             설 명             |
  | :------------: | :---------------------------: |
  |    NOT NULL    |   반드시 입력해야 하는 컬럼   |
  | AUTO_INCREMENT | 자동으로 숫자가 증가하도록 함 |
  |  PRIMARY KEY   |         기본키로 지정         |
  |    DEFAULT     |        기본 값을 설정         |
  |     UNIQUE     |           중복 불가           |

### 2.2 조회

- 스키마 등 제약조건을 볼 수 있는 명령어

  ```mysql
  DESC 테이블명;
  ```

- 현재 database의 모든 테이블 조회

  ```mysql
  SHOW tables;
  ```

### 2.3 수정

- 컬럼 추가

  ```mysql
  ALTER TABLE 테이블명 ADD 컬럼명 데이터타입;
  ```

- 컬럼 수정

  ```mysql
  ALTER TABLE 테이블명 MODIFY 컬럼명 데이터타입;
  ```

- 컬럼명 수정

  ```mysql
  ALTER TABLE 테이블명 CHANGE 컬럼명 새컬럼명 데이터타입;
  ```

- 컬럼 삭제

  ```mysql
  ALTER TABLE 테이블명 DROP 컬럼명;
  ```

### 2.4 삭제

- 테이블을 통째로 삭제하는 명령어

  ```mysql
  DROP table 테이블명;
  ```

- 정의는 남겨두고 데이터를 모두 삭제하는 명령어

  ```mysql
  TRUNCATE table 테이블명;
  ```




