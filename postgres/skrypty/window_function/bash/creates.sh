#! /bin/bash

mkdir -p /results/create/
psql --username "postgres" -c "CREATE DATABASE perf_tests;"
psql --username "postgres" --dbname "perf_tests" -f '/skrypty/window_function/sql/create_all.sql'
