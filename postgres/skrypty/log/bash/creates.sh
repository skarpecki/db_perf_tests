#! /bin/bash

psql --username "postgres" -c "CREATE DATABASE perf_tests;" 
psql --username "postgres" --dbname "perf_tests" -f /skrypty/log/sql/create_all.sql 