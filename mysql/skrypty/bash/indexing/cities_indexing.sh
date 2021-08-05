#! /bin/bash

mkdir -p /results/indexing
( time mysql -u 'root' -p$MYSQL_ROOT_PASSWORD -e "CREATE INDEX IX_cities ON perf_tests.cities (city);" > /dev/null ) |& tee /results/indexing/cities.txt