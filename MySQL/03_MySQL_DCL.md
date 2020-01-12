# 03_MySQL_DCL

- DCL(Data Control Language)는 DataBase의 데이터를 제어하는 언어
  - 데이터의 **보안, 무결성, 회복, 병행 수행체 등을 정의하는데 사용**한다.

## 1. 사용자

### 1.0 사용자 목록 확인

```mysql
USE mysql;

SELECT user FROM user;	# 사용자 ID 목록 간단 확인
```

### 1.1 사용자 생성

- 로컬에서만 접속 가능한 사용자 생성

  ```mysql
  CREATE USER 'userid'@localhost IDENTIFIED BY 'password';
  ```

- 모든 호스트에서 접속 가능한 사용자 생성

  ```mysql
  CREATE USER 'userid'@% IDENTIFIED by 'password';
  ```

### 1.2 사용자 비밀번호 변경

```mysql
SET PASSWORD FOR 'userid'@% = 'new password';
```

### 1.3 사용자 삭제

```mysql
DROP USER 'userid'@%;
```

### 1.4 권한 부여

```mysql
GRANT ALL ON *.* TO userid;				 # 모든 DB의 모든 테이블 사용 권한

GRANT ALL ON DB이름.* TO userid;			# 특정 DB의 모든 테이블 사용 권한

GRANT ALL ON DB이름.테이블명 TO userid;	  # 특정 DB의 특정 테이블 사용 권한
```

- **권한을 부여하고 적용**해야한다.

  ```mysql
  FLUSH PRIVILEGES;
  ```

### 1.4 권한 삭제

```mysql
REVOKE ALL ON DB이름.* FROM userid;
```

### 1.5 권한 확인하기

```mysql
SHOW GRANTS FOR userid;
```