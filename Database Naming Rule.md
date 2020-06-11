# Database Naming Rule

## 1. 공통

- 소문자를 사용

- 단어를 임의로 축약하지 않음

  > _register_date_ (O) / _reg_date_ (X)

- 가능하면 약어의 사용을 피함

  - 약어를 사용해야하는 경우, 약어 역시 소문자를 사용

- 동사는 능동태를 사용

  > _register_date_ (O) / _registered_date_ (X)



## 2. Table

- 단수형을 사용
- 이름을 구성하는 각각의 단어를 underscore(`_`)로 연결하는 snake_case를 사용
- 교차 테이블(many-to-many)의 이름에 사용 간으한 직관적인 단어가 있다면 해당 단어를 사용
  - 적절한 단어가 없다면 관계를 맺고 있는 각 테이블의 이름을 `_and_` 또는 `_has_`로 연결

> 1. article, movie : 단수형
> 2. vip_member
> 3. article_and_movie : 교차 테이블을 `_and_`로 연결



## 3. Column

- auto_increment 속성의 PK를 대리키로 사용하는 경우, **'테이블명'_id**의 규칙으로 명명
- 이름을 구성하는 각각의 단어를 underscore(`_`)로 연결하는 snake_case를 사용
- FK 컬럼은 부모 테이블의 PK 컬럼 이름을 그대로 사용
  - self 참조인 경우, PK 컬럼 이름 앞에 적절한 접두어를 사용
  - 같은 PK 컬럼을 자식 테이블에서 2번 이상 참조하는 경우, PK 컬럼 이름 앞에 적절한 접두어 사용
- boolean 유형의 컬럼이면 `_flag` 접미어 사용
- date, datetime 유형의 컬럼이면 `_date` 접미어 사용

> 1. article_id, movie_id
> 2. complete_flag
> 3. issue_date



## 4. Index

- 이름을 구성하는 각각의 단어를 hyphen(`-`)으로 연결하는 snake case 사용

- 접두어

  - unique index : uix
  - spatial index : six
  - index : nix

- '접두어'-'테이블명'-'컬럼 이름'-'컬럼 이름'

  > uix-account-login_email



## 5. Foreign Key

- 이름을 구성하는 각각의 단어를 hyphen(`-`)으로 연결하는 snake case 사용

- 'fk'-'부모 테이블 이름'-'자식 테이블 이름'
  - 같은 부모-자식 테이블에 2개 이상의 FK가 있는 경우, 넘버링

> 1. fk-movie-article : article 테이블이 movie 테이블 참조
> 2. fk-admin-notice-1 / fk-admin-notice-2 : notice 테이블이 admin 테이블을 2회 이상 참조하여 넘버링



## 6. View

- 접두어 'v'를 사용
- 기타 규칙은 Table과 동일

