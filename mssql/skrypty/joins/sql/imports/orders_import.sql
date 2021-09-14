BULK INSERT perf_tests.dbo.orders
FROM '/dane/orders.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\r\n');
