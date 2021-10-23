BULK INSERT perf_tests.dbo.employees_1
FROM '/dane/employees_1.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\r\n');