BULK INSERT perf_tests.dbo.departments
FROM '/dane/departments.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\r\n');
