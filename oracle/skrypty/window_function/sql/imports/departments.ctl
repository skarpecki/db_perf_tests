OPTIONS (SKIP=1)

LOAD DATA
	infile '/dane/departments.csv' "str '\r\n'"
	APPEND
	INTO TABLE perf_tests.departments
	FIELDS TERMINATED BY ','
	(
	DEPARTMENT_ID,
	NAME
	)
