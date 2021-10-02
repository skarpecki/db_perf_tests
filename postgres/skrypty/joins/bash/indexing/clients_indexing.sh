#! /bin/bash

psql --username "postgres" --dbname "perf_tests" -c "CREATE INDEX IX_clients ON clients (first_name, last_name);" 