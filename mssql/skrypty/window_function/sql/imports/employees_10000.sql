BULK INSERT perf_tests.dbo.employees_10000
FROM '/dane/employees_10000.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\r\n');