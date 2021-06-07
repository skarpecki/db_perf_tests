#! /bin/bash

mkdir -p /results/inserting/$1
( time /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -Q "INSERT INTO perf_tests.dbo.employees SELECT 1000001, 'John', 'Wick', 'john@wick.com', 1, 1, 1;" > /dev/null ) |& tee /results/inserting/$1/employees.txt