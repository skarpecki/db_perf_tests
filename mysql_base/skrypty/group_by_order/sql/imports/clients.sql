LOAD DATA INFILE '/dane/clients.csv' INTO TABLE perf_tests.clients
FIELDS TERMINATED BY ',' LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;