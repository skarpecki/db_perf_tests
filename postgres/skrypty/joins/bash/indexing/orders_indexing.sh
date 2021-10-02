#! /bin/bash

psql --username "postgres" --dbname "perf_tests" -c "CREATE INDEX IX_orders ON orders (part_num);" 
