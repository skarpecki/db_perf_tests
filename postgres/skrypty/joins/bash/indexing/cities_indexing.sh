#! /bin/bash

psql --username "postgres" --dbname "perf_tests" -c "CREATE INDEX IX_cities ON cities (city);" 