LOAD DATA INFILE '/dane/employees.csv' INTO TABLE perf_tests.employees
FIELDS TERMINATED BY ',' LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;