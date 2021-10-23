BULK INSERT perf_tests.dbo.cities
FROM '/dane/cities.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\r\n');