#! /bin/bash

mkdir -p /results/create/
mysql -u "root" -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS perf_tests;" 
mysql -u "root" -p$MYSQL_ROOT_PASSWORD < '/skrypty/window_function/sql/create_all.sql'
