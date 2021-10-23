BULK INSERT perf_tests.dbo.employees_100000
FROM '/dane/employees_100000.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\r\n');