1.각 사원(employee)에 대해서 사번(employee_id), 
이름(first_name), 부서명(department_name),
매니저(manager)의 이름(first_name)을 조회하시오.

select e.employee_id, e.first_name, d.department_name, m.first_name
from employees e join departments d
on e.department_id = d.department_id
join employees m
on e.manager_id = m.employee_id;

2. 자신의 매니저보다 연봉(salary)을 많이 받는 직원들의 
성(last_name)과 연봉(salary)을 출력하시오. 

select e.last_name, e.salary
from employees e left join employees m
on e.manager_id = m.employee_id
where e.salary > m.salary;

3. 업무명(job_title)이 ‘Sales Representative’인 직원 중에서
연봉(salary)이 9,000 이상, 10,000 이하인 
직원들의 이름(first_name), 성(last_name)과 연봉(salary)을
출력하시오.

select first_name, last_name, salary
from employees e join jobs j
on e.job_id = j.job_id
where lower(j.job_title) = lower('Sales Representative')
and e.salary between 9000 and 10000;

4. 자신의 매니저보다 채용일(hire_date)이 
빠른 사원의 사번(employee_id), 성(last_name)과 
채용일(hire_date)을 조회하라.

select e.employee_id, e.last_name, e.hire_date
from employees e left join employees m
on e.manager_id = m.employee_id
where e.hire_date < m.hire_date;

5. 각 업무(job_title)가 어느 부서(department_name)에서 
수행되는지 조회하는 SQL 쿼리문을 작성하세요. 
(단, 수행하지 않는 업무는 표시하지 않고 
중복되는 정보는 하나만 표시합니다.)
출력: JOB_TITLE | DEPARTMENT_NAME

select distinct job_title, department_name
from jobs j join employees e
on j.job_id = e.job_id
join departments d
on d.department_id = e.department_id;

6. 월 별 입사자 수를 조회하는 SQL 쿼리문을 작성하세요.
월 순으로 정렬하세요. 
출력: 월 | 입사자수

select to_char(hire_date,'MM') as 월, count(to_char(hire_date,'MM')) as 입사자수
from employees
group by to_char(hire_date,'MM')
order by to_char(hire_date,'MM');

7. 08년도에 입사한 직원의 이름(first_name), 
입사일(hire_date), 관리자사번(employee_id), 
관리자 이름(first_name)을 조회합니다.
단, 관리자가 없는 사원정보도 출력결과에 포함되어야 합니다..  

select e.first_name, e.hire_date, m.employee_id, m.first_name
from employees e left outer join employees m
on e.manager_id = m.employee_id
where to_char(e.hire_date,'yy') = '08'
or e.manager_id is null;

8. ‘Sales’부서에 속한 직원의 이름(first_name), 
급여(salary), 부서이름(department_name)을 조회하시오. 

select e.first_name, e.salary, d.department_name
from employees e join departments d
on e.department_id = d.department_id
where lower(d.department_name) = lower('Sales');

9. 2004년 입사한(hire_date) 직원들의 사번(employee_id), 
이름(first_name), 성(last_name), 부서명(department_name)을
조회합니다. 이때, 부서에 배치되지 않은 직원의 경우, 
‘<NOT ASSIGNED>’로 보여줍니다.

select e.employee_id, e.first_name, e.last_name, nvl2(e.manager_id,d.department_name,'<NOT-ASSIGNED>')
from employees e left outer join departments d
on e.department_id = d.department_id
where to_char(e.hire_date,'yyyy') = '2004'
or e.manager_id is null;

10. 2005년에 입사한 직원의 이름(first_name), 
입사일(hire_date), 관리자사번(employee_id), 
관리자 이름(first_name)을 조회합니다. 
단, 관리자가 없는 사원정보도 출력결과에 포함되어야 합니다.. 

select e.first_name, e.hire_date, m.employee_id, m.first_name
from employees e left outer join employees m
on e.manager_id = m.employee_id
where to_char(e.hire_date,'yyyy') = '2005'
or e.manager_id is null;
