LOAD DATA INFILE '/dane/employees_10.csv' INTO TABLE perf_tests.employees_10
FIELDS TERMINATED BY ',' LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;