
/* user table */
create table users(
	id varchar2(10) constraint users_id_pk primary key,
	password varchar2(10) constraint password_not_null not null,
	name varchar2(10),
	role varchar2(10)
);

/* board table */
create table board(
	seq number(5) constraint board_seq_pk primary key,
	title varchar2(20) constraint title_not_null not null,
	content varchar2(50),
	regdate date default sysdate,
	cnt number(5) default 0,
	id varchar2(10) constraint id_pk references users
);
// reference를 받는 테이블은 먼저 생성 될 수 없음, 테이블 생성에 
create table 
/*회원 등록 */
insert into users values ('java', 'java01', 'kim', 'admin');
insert into users values ('JAVA', 'JAVA', 'lee', 'user');
insert into users(id, password, name, role) values ('SQL', 'SQL', 'choi', 'user');

/* 회원정보 수정 */
update users set role = 'user';
update users set role = 'admin' where id='java';

/* 로그인 */

select nvl(nvl2(id,'성공',null),'실패') as "로그인 여부"
from users right join dual 
on id ='java' and password = 'java01';

select nvl(nvl2(id,'성공',null),'실패') as "로그인 여부"
from users right join dual
on id ='java' and password = 'java02';

alter table board modify(title varchar2(40));
alter table board modify(content varchar2(100));
/* 게시판 글등록 */
create sequence seq;


insert into board 
values (seq.nextval, 'java의 정석','java for while loop', '19/05/05', default, 'java');

insert into board 
values (seq.nextval, 'sql 더쉽게, 더 깊게', 'create grant select',
'19/02/24', default, 'JAVA');

insert into board 
values (seq.nextval, 'c++', 'pointer pointer reference',
'19/04/04', default, 'SQL');
insert into board 
values (seq.nextval, 'c', 'pointer pointer reference',
'19/03/04', default, 'java');

insert into board 
values (seq.nextval, 'c#', 'pointer pointer reference',
'19/02/04', default, 'JAVA');

insert into board 
values (seq.nextval, 'SSQQLL', 'pointer pointer reference',
'19/01/04', default, 'SQL');

insert into board 
values (seq.nextval, 'CC', 'pointer pointer reference',
'18/12/04', default, 'java');

insert into board 
values (seq.nextval, 'BB', 'pointer pointer reference',
'18/11/04', default, 'SQL');

insert into board 
values (seq.nextval, 'AA', 'pointer pointer reference',
'18/11/04', default, 'JAVA');

drop sequence seq;

/* 글 수정 */
update board set content = 'jsp jps jspsdpf sjp', title ='jsp' where seq = 4;
/* 글 삭제 */
delete from board where title is null;
/* 데이터검색 */
select * from board 
where (lower(title) like lower('%PO%'))
or (lower(content) like lower('%PO%'));


/* 전체 등록글 수 */
select count(*) from board;
/* 사용자별 등록글수 */
select id, count(*) from board group by id;
/* 월별게시글수 */
select to_char(regdate,'mm') as 월, count(*)
from board
group by to_char(regdate,'mm');
/* 사용자별 게시글 검색 */
select * from board where id='java';
/* 제목으로 게시글 검색 */
select id, title, regdate
from board
where title like '%sql%';
