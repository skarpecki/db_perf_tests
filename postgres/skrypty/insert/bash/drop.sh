#! /bin/bash

drop_statement="DROP TABLE clients;"
psql --username "postgres" --dbname "perf_tests" -c "$drop_statement"  