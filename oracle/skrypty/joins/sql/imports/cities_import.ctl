OPTIONS (SKIP=1)

LOAD DATA
	infile '/dane/cities.csv' "str '\r\n'"
	APPEND
	INTO TABLE perf_tests.cities
	FIELDS TERMINATED BY ','
	(
	CITY_ID,
	COUNTRY,
	CITY,
	POSTAL_CODE
    )
