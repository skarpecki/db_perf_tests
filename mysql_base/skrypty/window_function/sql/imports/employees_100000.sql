LOAD DATA INFILE '/dane/employees_100000.csv' INTO TABLE perf_tests.employees_100000
FIELDS TERMINATED BY ',' LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;