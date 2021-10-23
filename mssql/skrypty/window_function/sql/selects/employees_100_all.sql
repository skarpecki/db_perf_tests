SELECT e.first_name
		,e.last_name
        ,e.email
        ,d.name
        ,e.salary
        ,first_value(e.salary) OVER (PARTITION BY d.name ORDER BY salary DESC) AS max_salary_in_dept
        ,e.salary / (first_value(e.salary) OVER (PARTITION BY d.name ORDER BY salary DESC)) * 100 AS percentage_of_max_salary
FROM
perf_tests.dbo.employees_100 e
INNER JOIN perf_tests.dbo.departments d
	ON e.department_id = d.department_id;