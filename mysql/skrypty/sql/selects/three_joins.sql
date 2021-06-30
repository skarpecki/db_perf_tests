SELECT * FROM perf_tests.employees e 
INNER JOIN  perf_tests.addresses a ON e.address_id = a.address_id 
INNER JOIN perf_tests.companies c ON e.company_id = c.company_id
INNER JOIN perf_tests.departments d ON e.department_id = d.department_id;