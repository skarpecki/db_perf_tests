#! /bin/bash


for script in /skrypty/window_function/sql/imports/*.sql
do
    psql --username "postgres" --dbname "perf_tests" -f $script
done