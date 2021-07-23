SELECT * FROM perf_tests.employees e 
INNER JOIN  perf_tests.addresses a ON e.address_id = a.address_id
WHERE e.first_name='Jeff'
 	AND a.city = 'ELGIN';