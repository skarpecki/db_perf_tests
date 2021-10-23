#! /bin/bash

mysql -u 'root' -p$MYSQL_ROOT_PASSWORD -e "CREATE INDEX IX_cities ON perf_tests.cities (city);" 