select * from emp;
select ename, hiredate,to_char(hiredate,'yy'),
                  substr(hiredate,1,2) from emp;
select lower(ename) from emp;

select round(55.55), trunc(55.55) from dual;

select ename, deptno, sal, sal*1.1 from emp where deptno=10;

select ename, deptno, sal, decode(deptno, 10, sal*1.1, 20, sal*1.2, 30, sal*1.3) as '총급여' from emp;
/* decode (항목이, 값이면, 처리, 값, 처리, 값, 처리)  */
select ename, nvl(to_char(mgr),'X') from emp;
/* nvl 자동 형변환이 되지 않으므로 to_char 캐스팅 */
select ename, nvl2(mgr,'O','X') from emp;
/* nvl2(항목이, 널이 아니면, 널이면) 자동 형변환 */

select * from emp,dept; /* emp 테이블 행 * dept 행 */

select * from emp,dept where emp.deptno = dept.deptno;

select ename, job, dname, loc from emp, dept where emp.deptno = dept.deptno;
select ename, job, e.deptno, dname, loc from emp e, dept d where e.deptno = d.deptno;
/* 테이블 명이 길어질시 가독성이 저하되므로 emp를 e로 얼라이 dept를 d로 얼라이 */

/* ANSI 표준 : , => (inner) join where => on */

select ename, job, e.deptno, dname, loc from emp e inner join dept d on e.deptno = d.deptno;
/* ANSI 표준 */
select ename, job, sal, dname from emp e join dept d on e.deptno = d.deptno where e.sal>=2000;
/* 전통적인 방법 */
select ename, job, dname, sal from emp e, dept d where e. deptno = d.deptno and sal >=2000;
/* outer join */
select ename, job, dname, loc from emp, dept where emp.deptno(+) = dept.deptno;
/* outer join 마스터 테이블 설정 (left, right) */
select ename, job, d.deptno, dname, loc from emp e right outer join dept d on e.deptno = d.deptno;

select * from SALGRADE;

select ename, sal, grade
from emp, salgrade
where emp.sal between salgrade.losal and salgrade.hisal;

select ename, sal, grade
from emp e join salgrade
on sal between losal and hisal;
/* self join */
select e.ename as "사원이름", m.ename as "상사이름"
from emp e, emp m
where e.mgr = m.empno(+);
/* ANSI join */
select e.ename as "사원이름", nvl(m.ename,'<CEO>') as "상사이름"
from emp e left join emp m
on e.mgr = m.empno;

상사보다 입사일자가 빠른 사원
select e.ename 사원이름, e.hiredate 입사일, m.ename 상사이름, m.hiredate 상사입사일
from emp e left join emp m
on e.mgr = m.empno
where e.hiredate < m.hiredate;

select e.ename 사원이름, e.sal, m.ename 상사이름, m.sal
from emp e left join emp m
on e.mgr = m.empno
where e.sal > m.sal;

select e.ename 사원이름, e.sal, m.ename 상사이름, m.sal
from emp e, emp m
where e.mgr=m.empno and e.sal>m.sal;

======집계함수=====

select ename, round(sal) from emp;
select avg(sal) from emp;
select count(sal),count(comm), count(*), count(mgr) from emp;

select count(job) from emp; /* 12 */
select count(distinct job) from emp; /* 중복제거 5 */

select sum(sal),count(*),sum(sal)/count(*), round(avg(sal),1) from emp;

select deptno, max(sal), min(sal), sum(sal),count(*),sum(sal)/count(*), round(avg(sal),1) from emp
group by deptno; /* group by 절의 조건만 select 항목에 */
/* ANSI */
select e.deptno, d.dname, avg(e.sal)
from emp e join dept d 
on e.deptno = d.deptno 
group by e.deptno, d.dname 
order by e.deptno;
/* 오라클 */
/* 급여가 2000 이상인 직원들의 부서별 평균 급여 */
select e.deptno, d.dname, count(*), avg(e.sal)
from emp e, dept d
where e.deptno = d.deptno and e.sal>=2000
group by e.deptno, d.dname
order by e.deptno;

/* 평균 급여가 2000 이상인 부서 정보 출력 */
/* 실행순서 from > where > group by > having > order by > select */
/* 원하는 정보를 불러올 때의 알고리즘 : 
      from(어떤 테이블에서~) where(조건으로 필터링 하고)
      group by(원하는 항목으로 그룹화하는데) having(그룹화의 조건이 있다면) 데이터를 모아오고
      order by(정렬이 필요하다면 기준을 정하고) select(데이터를 선택하여 보여준다.) */
      /* join이 추가될시 from 뒤에 붙이고 on에 테이블을 조인하는 조건을 붙인다. */
   
select e.deptno, d.dname, avg(e.sal) 
from emp e, dept d
where e.deptno = d.deptno
group by e.deptno, d.dname
having avg(e.sal)>2000 
order by e.deptno;

/* 3개 테이블 조인 */
select ename, dname, sal, grade
from emp e, dept d, salgrade s
where e.deptno = d.deptno and (e.sal between s.losal and s.hisal);
/* ANSI 조인 */
select ename, dname, sal, grade
from emp e join dept d 
on e.deptno = d.deptno
join salgrade s
on (e.sal between s.losal and s.hisal);

select sal from emp where lower(ename)=lower('FORD');
select * from emp where sal >(select sal from emp where lower(ename)=lower('FORD'));

select * from emp where sal <(select round(avg(sal)) from emp);

select min(sal) from emp group by deptno;
/* group by 부서별 급여를 제일 적게 받는 사람을 찾을때는 in */
select * from emp where sal in (select min(sal) from emp group by deptno);

자신이 속한 부서의 평균보다 급여가 적은 사람 리스트 outer
select * 
from emp outer 
where sal < (select avg(sal) from emp where deptno = outer.deptno);

select rownum, ename, job, sal
from (select * from emp order by sal)
where rownum<4;

각 부서별 최고 급여를 받는 사람 리스트
select * from emp where sal in (select max(sal) from emp group by deptno);

select *
from emp
where (deptno, sal) in (select deptno, max(sal) from emp group by deptno);

select to_char(count(*)) as 직속부하직원수, to_char(manager_id) as 관리자사번,
 first_name as 관리자이름
from employees
group by manager_id
having count(*)>=8
order by count(*);

select count(*),e.manager_id, m.last_name
from employees e join employees m
on e.manager_id = m.employee_id
group by e.manager_id, m.last_name
having count(*) >=8
order by count(*);
