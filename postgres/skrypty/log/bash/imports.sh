#! /bin/bash


for script in /skrypty/log/sql/imports/*.sql
do
    psql --username "postgres" --dbname "perf_tests" -f $script
done