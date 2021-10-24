OPTIONS (SKIP=1)

LOAD DATA
	infile '/dane/employees_1000.csv' "str '\r\n'"
	APPEND
	INTO TABLE perf_tests.employees_1000
	FIELDS TERMINATED BY ','
	(
	CLIENT_ID,
	FIRST_NAME,
	LAST_NAME,
	EMAIL,
	CITY_ID,
	DEPARTMENT_ID,
	COMPANY_ID,
	SALARY
	) 
