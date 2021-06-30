BULK INSERT perf_tests.employees
FROM '/dane/employees.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\r\n');


BULK INSERT perf_tests.departments
FROM '/dane/departments.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\r\n');


BULK INSERT perf_tests.companies
FROM '/dane/companies.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\r\n');


BULK INSERT perf_tests.addresses
FROM '/dane/addresses.csv'
WITH (FIRSTROW=2, FIELDTERMINATOR=',', ROWTERMINATOR='\r\n');


	