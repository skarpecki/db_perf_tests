BULK INSERT perf_tests.dbo.employees
FROM '/dane/employees.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\r\n');


BULK INSERT perf_tests.dbo.departments
FROM '/dane/departments.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\r\n');


BULK INSERT perf_tests.dbo.companies
FROM '/dane/companies.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\r\n');


BULK INSERT perf_tests.dbo.addresses
FROM '/dane/addresses.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\r\n');


	