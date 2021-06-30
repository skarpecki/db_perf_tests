#! /bin/bash

mkdir -p /results/indexing
( time mysql -u 'root' -p$MYSQL_ROOT_PASSWORD -e "CREATE INDEX IX_addresses ON perf_tests.addresses (city);" > /dev/null ) |& tee /results/indexing/addresses.txt