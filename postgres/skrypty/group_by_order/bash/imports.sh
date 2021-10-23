#! /bin/bash


for script in /skrypty/group_by_order/sql/imports/*.sql
do
    psql --username "postgres" --dbname "perf_tests" -f $script
done