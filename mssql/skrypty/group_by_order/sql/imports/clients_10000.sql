BULK INSERT perf_tests.dbo.clients_10000
FROM '/dane/clients_10000.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\r\n');