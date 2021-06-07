SELECT * FROM perf_tests.dbo.employees e 
INNER JOIN  perf_tests.dbo.addresses a ON e.address_id = a.address_id
WHERE a.city = 'ELGIN' and e.first_name='Jeff';