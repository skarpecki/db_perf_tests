#! /bin/bash


for script in /skrypty/index/sql/imports/*.sql
do
    psql --username "postgres" --dbname "perf_tests" -f $script
done