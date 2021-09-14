BULK INSERT perf_tests.dbo.clients_100
FROM '/dane/clients_100.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\r\n');