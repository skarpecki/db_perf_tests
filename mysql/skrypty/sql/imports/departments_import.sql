LOAD DATA INFILE '/dane/departments.csv' INTO TABLE perf_tests.departments
FIELDS TERMINATED BY ',' LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;