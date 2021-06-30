#! /bin/bash

mkdir -p /results/indexing
( time mysql -u 'root' -p$MYSQL_ROOT_PASSWORD -e "CREATE INDEX IX_departments ON perf_tests.departments (name)" > /dev/null ) |& tee /results/indexing/departments.txt
