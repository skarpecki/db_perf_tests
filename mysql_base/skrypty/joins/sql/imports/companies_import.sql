LOAD DATA INFILE '/dane/companies.csv' INTO TABLE perf_tests.companies
FIELDS TERMINATED BY ',' LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;