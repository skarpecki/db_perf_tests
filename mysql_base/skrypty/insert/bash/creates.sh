#! /bin/bash

mkdir -p /results/creates/
mysql -u "root" -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS perf_tests;" > /dev/null
( time mysql -u "root" -p$MYSQL_ROOT_PASSWORD < /skrypty/insert/sql/create.sql  > /dev/null ) |& tee /results/creates/creates.txt
