#! /bin/bash

mysql -u 'root' -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE perf_tests;" 
mysql -u 'root' -p$MYSQL_ROOT_PASSWORD < /skrypty/joins/sql/create_all.sql  