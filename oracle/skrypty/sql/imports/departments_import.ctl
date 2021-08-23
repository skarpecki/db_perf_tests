OPTIONS (SKIP=1, ERRORS=100000, BINDSIZE=8000000, ROWS=5000)

LOAD DATA
	infile '/dane/departments.csv' "str '\r\n'"
	INSERT
	INTO TABLE perf_tests.departments
	FIELDS TERMINATED BY ','
	(
	DEPARTMENT_ID,
	NAME
    )
