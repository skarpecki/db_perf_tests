LOAD DATA INFILE '/dane/addresses.csv' INTO TABLE perf_tests.addresses
FIELDS TERMINATED BY ',' LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;