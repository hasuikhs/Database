# 03_MySQL_DCL

## 1. 접속 

```bash
$ mysql -u root -p
```

## 2. 사용자

### 2.1 사용자 생성

```mysql
$ create user userid identified by "password";
$ create user userid@localhost identified by "password";
```

### 2.2 사용자 삭제

```mysql
$ drop user userid;
```

### 2.3 권한 부여

```mysql
$ grant all on *.* to userid;

$ grant all on DB이름.* to userid;

$ grant all on DB이름.테이블명 to userid;

$ grant select on DB이름.테이블명 to userid;

$ grant update(컬럼1, 컬럼2) on DB이름.테이블명 to userid;
```

### 2.4 권한 삭제

```mysql
$ revoke all on DB이름.* from userid;
```

### 2.5 권한 확인하기

```mysql
$ show grants for userid;
```