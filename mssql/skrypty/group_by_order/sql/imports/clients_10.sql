BULK INSERT perf_tests.dbo.clients_10
FROM '/dane/clients_10.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\r\n');