select * from DEPT;
select * from EMP;
select empno,ename,job,hiredate,deptno from emp;
select ename as 사원명, job as "업 무", sal as 급_여, comm as 수당 from emp;
select distinct job from emp;
select ename,sal,sal*12 as 연봉 from emp;
select ename, sal, comm, sal+comm from emp;

select ename, sal, comm, nvl(sal+comm,sal) from emp;
select ename, nvl(to_char(mgr),'없음') from emp;
select ename, mgr, 'sql' from emp;

select ename, sal, comm, sal+nvl(comm,0)||'원' as 총급여 from emp;

select ename, job, hiredate, deptno from emp;
select ename|| job|| hiredate|| deptno from emp;
/* || 연결 연산자 */

select sysdate from emp;
select sysdate from dual; /* dual 가상의 테이블 */

select * from emp where job = 'MANAGER';
select * from emp where upper(job) != upper('manager');

select * from emp where hiredate > '81/05/01';

select * from emp where sal>=2000 and sal<=3000;
select * from emp where sal between 2000 and 3000;
select * from emp where sal not between 2000 and 3000;

select * from emp where deptno = 10 or deptno = 20;
select * from emp where deptno in(10,20); /* or = in("","") */

select * from emp where deptno !=10 and deptno !=20;
select * from emp where deptno not in(10,20);
select * from emp where deptno <> all(10,20);

select * from dept;
select * from dept where deptno = 20 and loc ='DALLAS';
select * from dept where deptno = 30 and loc ='CHICAGO';

select * from dept where (deptno = 20 and loc = 'DALLAS') or (deptno = 30 and loc = 'CHICAGO');
select * from dept where (deptno, loc) in ((20, 'DALLAS'),(30,'CHICAGO'));

select * from emp where ename = 'KING';
select * from emp where job like 'S%';

select * from emp where hiredate like '82%';
select * from emp where comm is null;
select * from emp where comm is not null;

select * from emp order by deptno;
select * from emp order by deptno desc;
select * from emp order by 1;
select * from emp order by 5,deptno;

select ename, sal, comm,sal +nvl(comm,0) as total from 
emp where sal +nvl(comm,0) > 1000
order by total;

select sysdate from dual;
select sysdate, to_char(sysdate,'MM') from dual;
select sysdate, to_char(sysdate,'YYYY') from dual;
select sysdate, to_char(sysdate,'YY') from dual;

select to_char(hiredate,'mm') from emp;
select to_char(hiredate,'day') from emp;

INSERT INTO EMP VALUES
(7934,'MILLER','CLERK',7782,to_date('23-1-1982','dd-mm-yyyy'),1300,NULL,10);

insert into emp values (9999,'java01','CLERK',7782,sysdate,900,null,10);
rollback;

insert into emp values (9999,'java01','CLERK',7782,to_date('05/13/19','mm/dd/yy'),900,null,10);
rollback;

select * from emp where ename like '%/%%'; /* 이름에 % or _ 가 들어가는 경우를 찾고 싶을 때 / 추가 */