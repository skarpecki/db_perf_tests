BULK INSERT perf_tests.dbo.employees
FROM '/dane/employees.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\r\n');