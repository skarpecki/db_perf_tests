BULK INSERT perf_tests.dbo.employees_1000
FROM '/dane/employees_1000.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\r\n');