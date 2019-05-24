select rownum, ename, job, sal
from (select * from emp order by sal desc)
where rownum < 4;

select rownum, ename, job, sal
from (select * from emp order by sal desc)
where rownum between 1 and 4;

select row#, ename, job, sal
from 
(
	select rownum row#, ename, job, sal 
	from (select * from emp order by sal desc)
)
where row# between 1 and 4;

/*81년도에 입사한 사람 중 월급여 상위 3명*/

select row#, ename, job, hiredate, sal
from
(select rownum row#, ename,job, hiredate, sal
from(select * from emp where hiredate like '81%' order by sal desc)
)
where row# >4;