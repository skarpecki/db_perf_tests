OPTIONS (SKIP=1)

LOAD DATA
	infile '/dane/clients.csv' "str '\r\n'"
	INSERT
	INTO TABLE perf_tests.clients
	FIELDS TERMINATED BY ','
	(
	CLIENT_ID,
	FIRST_NAME,
	LAST_NAME,
	EMAIL,
	CITY_ID,
	DEPARTMENT_ID,
	COMPANY_ID 
	) 
