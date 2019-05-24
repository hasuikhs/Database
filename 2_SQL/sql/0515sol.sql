drop table board;
drop table users;

create users table(
	id       varchar2(8)  primary key,
	password varchar2(8)  not null,
	name     varchar2(20) not null,
	role     varchar2(8)  default 'user'
);

create board table(
	seq     number(5)    primary key,
	title   varchar2(20) not null,
	content varchar2(800) not null,
	regdate date         default sysdate,
	cnt     number(5)    default 0,
	id      varchar2(8)  references users
);

회원등록
insert into users(id, password, name) values('java01','1234','홍길동');
insert into users(id, password, name) values('java02','1234','홍길동');
insert into users values('admin','1234','admin','admin');

commit;

게시판 글등록

insert into board(seq, title, content, id) 
values ( (select nvl(max(seq),0)+1 from board),'공지','~~~' ,'admin');

insert into board(seq, title, content, id) 
values ( (select nvl(max(seq),0)+1 from board),'추가','~~~' ,'java01');

insert into board(seq, title, content, id) 
values ( (select nvl(max(seq),0)+1 from board),'연습1','~!!!~~' ,'java02');

insert into board(seq, title, content, id) 
values ( (select nvl(max(seq),0)+1 from board),'연습2','~~~@@@@' ,'java02');

commit;

select * from board where id = 'java01';

select * from board where seq = 1;
월별 게시물
select to_char(regdate,'mm'), count(*) from board group by to_char(regdate,'mm');

글삭제

글 수정

로그인

select * from users where id='' and password='';