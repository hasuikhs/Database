# Index

## 1. 생성

### 1.1 추가

```mysql
CREATE INDEX 인덱스명 ON 테이블명 (컬럼명1, 컬럼명2, ...);
```

### 1.2 테이블 생성시

```mysql
CREATE TABLE 테이블명 (
	...
    INDEX 인덱스명 (컬럼명1, 컬럼명2, ...)
);
```

### 1.3 변경

```mysql
ALTER TABLE 테이블명 ADD INDEX 인덱스명 (컬럼명);
```

## 2. 보기

```mysql
SHOW INDEX FROM 테이블명;
```

## 3. 삭제

```mysql
ALTER TABLE 테이블명 DROP INDEX 인덱스명;
```

