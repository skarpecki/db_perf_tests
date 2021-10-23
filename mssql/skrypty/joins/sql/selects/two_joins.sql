SELECT * FROM perf_tests.dbo.clients cl 
INNER JOIN  perf_tests.dbo.cities ci ON cl.city_id = ci.city_id 
INNER JOIN perf_tests.dbo.companies co ON cl.company_id = co.company_id;