LOAD DATA INFILE '/dane/employees_1000.csv' INTO TABLE perf_tests.employees_1000
FIELDS TERMINATED BY ',' LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;