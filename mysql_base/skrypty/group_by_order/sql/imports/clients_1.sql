LOAD DATA INFILE '/dane/clients_1.csv' INTO TABLE perf_tests.clients_1
FIELDS TERMINATED BY ',' LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;