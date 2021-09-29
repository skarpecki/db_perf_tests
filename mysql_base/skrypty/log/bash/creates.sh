#! /bin/bash

mysql -u "root" -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS perf_tests;"
mysql -u "root" -p$MYSQL_ROOT_PASSWORD < /skrypty/log/sql/create_all.sql  