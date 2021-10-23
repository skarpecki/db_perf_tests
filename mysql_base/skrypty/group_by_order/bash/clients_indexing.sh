#! /bin/bash

mysql -u 'root' -p$MYSQL_ROOT_PASSWORD \
-e "CREATE INDEX IX_clients ON perf_tests.clients (first_name, last_name);" 

for i in $(seq 0 6)
do
    val=$(( 10 ** i ))
    mysql -u 'root' -p$MYSQL_ROOT_PASSWORD \
    -e "CREATE INDEX IX_clients_$val ON perf_tests.clients_$val (first_name, last_name);" 
done