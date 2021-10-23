SELECT * FROM perf_tests.dbo.clients cl 
INNER JOIN  perf_tests.dbo.cities ci ON cl.city_id = ci.city_id;
