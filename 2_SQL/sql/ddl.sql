/* DDL : create, drop, alter : rollback 불가 auto commit*/
select * from tab; /* table list */
drop table book;
create table book(
	bookno number(5),
	title varchar2(12),
	author varchar2(12),
	pubdate date
);

show recyclebin; /* 휴지통 보기 */
purge recyclebin; /* 휴지통 비우기 */

select * from book;
/* DML */
insert into book values(1,'java','kim',sysdate); /* 다른 곳에서 조회 안됨 */

rollback; /* 되돌리기 */

insert into book values(1,'java','kim',sysdate);
insert into book values(1, 'java','kim',sysdate);
insert into book values(2, null, null, '19/05/15');

insert into book(bookno, title, author,pubdate) values (3,'sql','lee',null);
insert into book(bookno, title, author) values (4,'db','java01');
commit; /* 확정 다른 곳에서 조회 가능 */

delete from book; /* rollback */
delete from book where title is null;

alter table book add(price number(7)); /* 북테이블에 항목 추가 */

insert into book values(5, default, default, default, default);
update book set price  = null; /* 전체 업데이트 */
update book set price  = 10, title ='jsp' where bookno = 1;

alter table book modify(price number(7, 2));/* 해당 항목이 비워져(null) 이어야 변경 가능 */
alter table book drop column price; /* 항목 삭제 */

rename book to book2; /* table rename */
rename book2 to book;

delete from book;
rollback;

truncate table book; /* DDL rollback 불가 */

drop table book;
/*-----------------------------------------------------------------------------------------*/
select * from emp;
select * from dept;

create table emp2 as select * from emp; /* 테이블 복사 */
create table emp3 as select * from emp where deptno=10; /* 조건 복사 */

create table dept2 as select * from dept;

insert into dept values (50, 'HR', 'SEOUL');
insert into dept2 values (50, 'HR', 'SEOUL');

commit;

insert into dept values (10, 'HR', 'SEOUL'); /* 기존테이블 유니크 중복 추가 불가 */
insert into dept2 values (10, 'HR', 'SEOUL'); /* 추가 가능 */

/* 테이블 제약조건 설정 */
create table book(
	bookno number(5) constraint scott_book_pk primary key,
	title varchar2(12) constraint book_title_unique unique,
	author varchar2(12),
	price number(5) constraint book_price_check check(price > 0),
	pubdate date default sysdate 
);

insert into book(bookno, title, author, price, pubdate) values(1, 'java 1', 'kim', 9000, sysdate);
insert into book(bookno, title, author, price, pubdate) values(2, 'java 2', 'kim', 9000, sysdate);
insert into book(bookno, title, author, price, pubdate) values(3, null, 'kim', 9000, sysdate);
insert into book(bookno, title, author, price, pubdate) values(4, 'java 4', 'lee', 9000, default);
insert into book(bookno, title, price) values(5, 'java 5', 9000);

select * from book;
/* 현재 계정 제약 조건들 보기 */
select constraint_name from user_cons_columns;
select constraint_name from user_cons_columns where table_name='BOOK';

drop table book;
drop table book cascade constraint; /* 테이블 강제 삭제 */

create table book(
	bookno number(5)  primary key,
	title varchar2(12)  unique,
	author varchar2(12),
	price number(5)  check(price > 0),
	pubdate date default sysdate 
);

drop table book;

create table book(
	bookno number(5),
	title varchar2(12) unique,
	author varchar2(12),
	price number(5) check(price > 0),
	pubdate date default sysdate 
);
desc book; /* book table 제약 보기 */
/* 키 설정 & 해제 */
alter table book add constraint book_bookno_pk primary key(bookno);
alter table book drop constraint book_bookno_pk;
drop table dept2;

create table dept2 as select * from dept;
/* dept2 테이블에 deptno 컬럼에 pk 설정 */
/* emp2 테이블에 empno 컬럼에 pk 설정 */
alter table dept2 add constraint dept2_deptno_pk primary key(deptno);
alter table emp2 add constraint emp2_empno_pk primary key(empno);
/* emp2 테이블에 mgr  컬럼에 fk 설정 */
alter table emp2 add foreign key(deptno) references dept2;

select ename, dname, sal, grade
from emp e join dept d 
on e.deptno = d.deptno
join salgrade s
on (e.sal between s.losal and s.hisal);

/* view 생성 update delete 불가*/
create or replace view emp_detail_view 
as select ename, dname, sal, grade
from emp e join dept d 
on e.deptno = d.deptno
join salgrade s
on (e.sal between s.losal and s.hisal);

select * from emp_detail_view;

drop view emp_detail_view;

insert into emp3 select * from emp1 where deptno = 20;

update emp set sal = sal * 1.1 where deptno = 10;

/* book 테이블 */
/* 시퀀스 번호 생성기 */
create sequence bookno;

insert into book(bookno, title, price) values(bookno.nextval, 'SQL1', 7000);
/* 현재 번호 출력 */
select bookno.currval from dual;

drop sequence bookno;

create table book(
	bookno number(5) primary key,
	title varchar2(12) ,
	author varchar2(12),
	price number(5) check(price > 0),
	pubdate date default sysdate 
);

select nval(max(bookno),0)+1 from book;

insert into book(bookno, title, price)
values((select nvl(max(bookno),0)+1 from book),'SQL',7000);

set autotrace on;

create index book_title on book(title);
drop index book_title;

set autotrace off;
select index_name,table_name from user_indexes;


drop index book_title;