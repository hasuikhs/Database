# Date/Time

## 1. Data Type

- date와 time types

  | Data Type |         Value         |    표시    |
  | :-------: | :-------------------: | :--------: |
  |   DATE    |     '0000-00-00'      |    날짜    |
  |   TIME    |      '00:00:00'       |    시간    |
  | DATETIME  | '0000-00-00 00:00:00' | 날짜, 시간 |
  | TIMESTAMP | '0000-00-00 00:00:00' | 날짜, 시간 |

## 2. DATE_FORMAT

- 시간을 원하는 형태로 출력해보자

  |    FORMAT     |              설명               |
  | :-----------: | :-----------------------------: |
  |      %M       |   월(January, December, ...)    |
  |      %W       |    요일(Sunday, Monday, ...)    |
  |      %D       |     월(1st, 2nd, 3rd, ...)      |
  |      %Y       |     연도(1989, 2000, 2020)      |
  |      %y       |        연도(89, 00, 20)         |
  |      %X       | 연도(1989, 2000) %V와 같이 쓰임 |
  |      %x       | 연도(1989, 2000) %v와 같이 쓰임 |
  |      %a       |       요일(Sun, Tue, ...)       |
  |      %d       |         일(00, 01, 02)          |
  |      %e       |           일(0, 1, 2)           |
  |      %c       |        월(1, 2, 3, ...)         |
  |      %b       |        월(Jan, Feb, ...)        |
  |      %H       |       시(00, 01, 02, 13)        |
  |      %h       |         시(01, 02, 12)          |
  |   %I(아이)    |         시(01, 02, 12)          |
  | %l(소문자 엘) |          시(1, 2, 12)           |
  |      %i       |         분(00, 01, 30)          |
  |      %r       |        "hh:mm:ss AM\|PM"        |
  |      %T       |           "hh:mm:ss"            |
  |      %S       |               초                |
  |      %s       |               초                |
  |      %p       |             AM, PM              |
  |      %w       |     요일(0, 1, 2) 0: 일요일     |
  |      %U       |        주(시작 : 일요일)        |
  |      %u       |        주(시작 : 월요일)        |
  |      %V       |        주(시작 : 일요일)        |
  |      %v       |        주(시작 : 월요일)        |

- 예시

  ```mysql
  $ SELECT DATE_FORMAT(now(), "%Y %c/%d %r");
  
  +-----------------------------------+
  | date_format(now(), "%Y %c/%d %r") |
  +-----------------------------------+
  | 2020 1/15 03:20:08 PM             |
  +-----------------------------------+
  1 row in set (0.00 sec)
  ```

## 3. DATE_ADD, DATE_SUB

- 시간 더하기(DATE_ADD)

  ```mysql
  DATE_ADD('기준 날짜', INTERVAL '숫자' '타입');
  ```

- 시간 빼기(DATE_SUB)

  ```mysql
  DATE_SUB('기준 날짜', INTERVAL '숫자' '타입');
  ```

- 타입

  - SECOND, MINUTE, HOUR, DAY, MONTH, YEAR

## 4. 날짜 파싱하기

- YEAR()
- MONTH()
- DAY()
- HOUR()
- MINUTE()
- SECOND()
- MICROSECOND()

## 5. 날짜별 통계

- 일별

  ```mysql
  SELECT count(*), date_format(stat_dt, '%d') FROM tb GROUP BY date_format(stat_dt, '%d');
  ```

- 월별

  ```mysql
  SELECT count(*), date_format(stat_dt, '%m') FROM tb GROUP BY date_format(stat_dt, '%m');
  ```

- 위처럼 `%Y`, `%m`, `%d`를 잘 섞어주면 연,월,일별 통계를 쉽게 구할 수 있음