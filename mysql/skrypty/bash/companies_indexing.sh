#! /bin/bash

mkdir -p /results/indexing
( time mysql -u 'root' -p$MYSQL_ROOT_PASSWORD -e "CREATE INDEX IX_companies ON perf_tests.companies (name, sector)" > /dev/null ) |& tee /results/indexing/companies.txt