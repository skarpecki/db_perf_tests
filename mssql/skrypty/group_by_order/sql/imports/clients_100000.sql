BULK INSERT perf_tests.dbo.clients_100000
FROM '/dane/clients_100000.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\r\n');