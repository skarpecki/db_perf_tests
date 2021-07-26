SELECT TOP 10
	   first_name, 
	   last_name,
	   count(*) as count
FROM perf_tests.dbo.employees e
GROUP BY e.first_name,
		 e.last_name
ORDER BY count DESC