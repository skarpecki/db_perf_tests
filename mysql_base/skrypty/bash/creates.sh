#! /bin/bash

mkdir -p /results/creates/
mysql -u 'root' -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE perf_tests;" > /dev/null
( time mysql -u 'root' -p$MYSQL_ROOT_PASSWORD < /skrypty/sql/create_all.sql  > /dev/null ) |& tee /results/creates/creates.txt

