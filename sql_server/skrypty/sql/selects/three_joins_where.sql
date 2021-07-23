SELECT * FROM perf_tests.dbo.employees e 
INNER JOIN  perf_tests.dbo.addresses a ON e.address_id = a.address_id 
INNER JOIN perf_tests.dbo.companies c ON e.company_id = c.company_id
INNER JOIN perf_tests.dbo.departments d ON e.department_id = d.department_id
WHERE  e.first_name='Jeff'
	AND a.city = 'ELGIN' 
	AND c.sector = 'Pharma'
	AND d.name = 'Marketing';