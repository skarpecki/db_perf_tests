BULK INSERT perf_tests.dbo.clients_1
FROM '/dane/clients_1.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\r\n');