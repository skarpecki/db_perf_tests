#! /bin/bash

create_script='/skrypty/insert/sql/create.sql'
psql --username "postgres" -c "CREATE DATABASE perf_tests;" 
psql --username "postgres" --dbname "perf_tests" -f "$create_script"
