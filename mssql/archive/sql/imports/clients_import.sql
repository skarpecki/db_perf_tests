BULK INSERT perf_tests.dbo.clients
FROM '/dane/clients.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\r\n');