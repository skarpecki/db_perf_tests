OPTIONS (SKIP=1)

LOAD DATA
	infile '/dane/companies.csv' "str '\r\n'"
	INSERT
	INTO TABLE perf_tests.companies
	FIELDS TERMINATED BY ','
	(
	COMPANY_ID,
	NAME,
	SECTOR,
	LEGAL_FORM
    )