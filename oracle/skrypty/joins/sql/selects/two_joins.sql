SELECT * FROM perf_tests.clients cl 
INNER JOIN  perf_tests.cities ci ON cl.city_id = ci.city_id 
INNER JOIN perf_tests.companies co ON cl.company_id = co.company_id;