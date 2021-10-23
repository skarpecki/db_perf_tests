BULK INSERT perf_tests.dbo.employees_100
FROM '/dane/employees_100.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\r\n');