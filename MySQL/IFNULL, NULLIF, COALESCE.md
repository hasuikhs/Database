# IFNULL, NULLIF, COALESCE

## 1. IFNULL

- `IFNULL(expr1, expr2)`
- 첫번째 값이 null이면 두번째 값을 반환하고, 첫번째 값이 null이 아니면 첫번째 값을 그대로 반환

```mysql
SELECT IFNULL(null, 1) FROM DUAL; # 1

SELECT IFNULL(1, null) FROM DUAL; # 1

SELECT IFNULL(1/0, 10) FROM DUAL; # 10
```

## 2. NULLIF

- `NULLIF(expr1, expr2)`
- 첫번쨰 값과 두번쨰 값이 같으면 null을 반환하고, 다르면 첫번째 값을 반환

```mysql
SELECT NULLIF(1, 1) FROM DUAL; # null

SELECT NULLIF(1, 2) FROM DUAL; # 1
```

## 3. COALESCE

- `COALESCE(expr1, expr2, ...)`
- 지정한 값들 중에 null이 아닌 첫번째 값을 반환

```mysql
SELECT COALESCE(null, null, null, null, 1) FROM DUAL; # 1
```

