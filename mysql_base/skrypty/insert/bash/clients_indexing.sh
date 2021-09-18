#! /bin/bash

mkdir -p /results/index
( time mysql -u 'root' -p$MYSQL_ROOT_PASSWORD \
-e "CREATE INDEX IX_clients ON perf_tests.clients (first_name, last_name);" ) \
|& tee /results/index/clients.txt