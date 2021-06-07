BULK INSERT perf_tests.dbo.companies
FROM '/dane/companies.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\r\n');
