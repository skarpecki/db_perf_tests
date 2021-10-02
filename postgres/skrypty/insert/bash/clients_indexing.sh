#! /bin/bash

index_query='CREATE INDEX IX_clients ON clients (first_name, last_name);'
psql --username "postgres" --dbname "perf_tests" -c "$index_query"