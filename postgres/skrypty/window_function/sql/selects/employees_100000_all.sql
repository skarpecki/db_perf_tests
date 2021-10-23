SELECT e.first_name
		,e.last_name
        ,e.email
        ,d.name
        ,e.salary
        ,first_value(e.salary) OVER w AS max_salary_in_dept
        ,e.salary / (first_value(e.salary) OVER w) * 100 AS percentage_of_max_salary
FROM 
employees_100000 e
INNER JOIN departments d
	ON e.department_id = d.department_id
WINDOW w AS (PARTITION BY d.name ORDER BY salary DESC);