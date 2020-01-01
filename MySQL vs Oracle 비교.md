## MySQL vs Oracle 비교

## 1. 명령어

|       기능        |                            MySQL                             |                         Oracle                         |
| :---------------: | :----------------------------------------------------------: | :----------------------------------------------------: |
|   Null 값 처리    |                  IFNULL('컬럼값', '대체값')                  |                NVL('컬럼값', '대체값')                 |
|   문자열 합치기   |                 CONCAT('값1', '값2', '값3')                  |   CONCAT('값1', '값2') 또는 '값1'\|\|'값2'\|\|'값3'    |
| 데이터 1개만 보기 |                           LIMIT 1                            |                    WHERE ROWNUM = 1                    |
| 시스템 현재 시간  |                            NOW()                             |                        SYSDATE                         |
|    alias 사용     |         as 'alias 명' 또는 alias 명 또는 as alias 명         |                as alias명 또는 alias 명                |
|   날짜형식 변환   |                 DATE_FORMAT(NOW(), '%Y%m%d')                 |              TO_DATE(SYSDATE, 'YYYYMMDD')              |
|     날짜표기      |               '%Y-%m-%d %H:%s'(년-월-일 시:분)               |                  'YYYY_MM_DD HH24:MI'                  |
|     IF문 활용     |                IF(조건식, True 값, False 값)                 | DECODE(조건식, 일치해야하는 조건값, True 값, False 값) |
|     다중 조건     | CASE         WHEN '비교할 조건1' THEN '반환할 값'         WHEN '비교할 조건2' THEN '반환할 값2'         ELSE '그밖의 조건으로 반환할 값'   END |                          같음                          |
|   문자열 자르기   | SUBSTRING(문자열, 1, 10), LEFT(문자열, 3), RIGHT(문자열, 3)  |                 SUBSTR(문자열, 1, 10)                  |

## 2. 데이터 타입

|     Oracle     |      MySQL       |
| :------------: | :--------------: |
|   number(11)   |     int(11)      |
|  varchar2(30)  |   varchar(30)    |
|    char(30)    |     char(30)     |
|   number(3)    |     tinyint      |
|   number(5)    |     smallint     |
|   number(8)    |    mediumint     |
|   number(10)   |       int        |
|   number(10)   |     integer      |
|   number(20)   |      bigint      |
| number(10, 5)  |      double      |
|      raw       |       bit        |
|   blob, raw    |       blob       |
|      date      |       date       |
|      date      |     datetime     |
|   float(24)    |     decimal      |
|   float(24)    |      double      |
|   float(24)    | double precision |
|    varchar2    |       enum       |
|     float      |      float       |
|   blob, raw    |     longblob     |
|   clob, raw    |     longtext     |
|   blob, raw    |    mediumblob    |
|   number(7)    |    mediumint     |
|   clob, raw    |    mediumtext    |
|     number     |     numeric      |
|   float(24)    |       real       |
|    varchar2    |       set        |
| varchar2, clob |       text       |
|      date      |       time       |
|      date      |    timestamp     |
|      raw       |     tinyblob     |
|   number(3)    |     tinyint      |
|    varhar2     |     tinytext     |
|     number     |       year       |

