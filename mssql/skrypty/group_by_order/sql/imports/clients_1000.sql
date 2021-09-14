BULK INSERT perf_tests.dbo.clients_1000
FROM '/dane/clients_1000.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\r\n');