BULK INSERT perf_tests.dbo.addresses
FROM '/dane/addresses.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\r\n');