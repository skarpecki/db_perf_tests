#! /bin/bash

mkdir -p /results/indexing
( time mysql -u 'root' -p$MYSQL_ROOT_PASSWORD -e "CREATE INDEX IX_orders ON perf_tests.orders (part_num);" > /dev/null ) |& tee /results/indexing/orders.txt
