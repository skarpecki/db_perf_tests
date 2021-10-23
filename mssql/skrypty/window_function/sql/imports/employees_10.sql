BULK INSERT perf_tests.dbo.employees_10
FROM '/dane/employees_10.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\r\n');