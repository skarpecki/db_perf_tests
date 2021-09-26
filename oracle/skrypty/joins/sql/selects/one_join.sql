SELECT * FROM perf_tests.clients cl 
INNER JOIN  perf_tests.cities ci ON cl.city_id = ci.city_id;
