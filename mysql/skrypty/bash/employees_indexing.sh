#! /bin/bash

mkdir -p /results/indexing
( time mysql -u 'root' -p$MYSQL_ROOT_PASSWORD -e "CREATE INDEX IX_employees ON perf_tests.employees (first_name, last_name)" > /dev/null ) |& tee /results/indexing/employees.txt
