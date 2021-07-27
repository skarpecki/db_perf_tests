SELECT * FROM perf_tests.dbo.orders o 
INNER JOIN perf_tests.dbo.clients cl ON o.client_id = cl.client_id
INNER JOIN  perf_tests.dbo.cities ci ON cl.city_id = ci.city_id 
INNER JOIN perf_tests.dbo.companies co ON cl.company_id = co.company_id
WHERE o.part_num = '4162pr0029'