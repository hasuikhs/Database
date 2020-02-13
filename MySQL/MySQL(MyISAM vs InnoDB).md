# MySQL(MyISAM vs InnoDB)

## 1. InnoDB

- 트랜젝션을 지원하므로 트랜젝션-세이프(transactional-safe)
- Commit, Rollback, 장애복구, row-level locking, 외래키 등 다양한 기능 지원
- 장점
  - 데이터 무결성 보장
  - 제약조건,  외래키 생성, 동시성 제어 가능
  - Row-level Lock(행 단위 Lock)을 사용하기 때문에 **변경 작업(INSERT, DELETE, UPDATE)가 빠름**
- 단점
  - 여러가지 기능을 제공하다보니 데이터 모델 디자인에 많은 시간 필요
  - 시스템 자원을 많이 사용함
  - Full-text 인덱싱 불가능

## 2. MyISAM

- 장점
  - 비-트랜젝션-세이프(non-transactional-safe) 테이블을 관리
  - InnoDB에 비해 별다른 기능이 없으므로 **데이터 모델 디자인이 단순**
  - **SELECT 작업 속도가 빠르므로 읽기 작업에 적합**
  - Full-text 인덱싱이 가능하여 검색하고자 하는 내용에 대한 복합 검색 가능
- 단점
  - 데이터 무결성을 보장하지 않음
  - 트랜젝션을 지원하지 않기에 작업도중 문제가 생겨도 이미 작성한 내용들이 INSERT 됨
  - Talbe-level Lock을 사용하기 때문에 쓰기 작업(INSERT, DELETE) 속도가 느림

## 3. 비교

### 3.1 InnoDB이 유리한 경우

- 대용량의 데이터를 컨트롤 하는 경우
- 트랜잭션 관리가 필요한 경우
- 복구가 필요할 경우
- 정렬등의 구문이 들어가는 경우
- IUD 등이 빈번하게 발생하는 경우(Row-Level locking 때문에)

### 3.2 MyISAM이 유리한 경우

- 읽기 위주의 작업만 필요할 경우
- 전문 검색이 필요할 경우
- 트랜잭션이나 복구등이 필요 없을 경우
- 한번에 대량의 데이터를 입력하는 배치성 테이블
