SELECT * FROM perf_tests.orders o 
INNER JOIN perf_tests.clients cl ON o.client_id = cl.client_id
INNER JOIN  perf_tests.cities ci ON cl.city_id = ci.city_id 
INNER JOIN perf_tests.companies co ON cl.company_id = co.company_id