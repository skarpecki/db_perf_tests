#! /bin/bash

psql --username "postgres" --dbname "perf_tests" -c "CREATE INDEX IX_companies ON companies (name, sector);"