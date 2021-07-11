#! /bin/bash

mkdir -p /results/indexing
( time /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD \
-Q "CREATE NONCLUSTERED INDEX IX_employees ON perf_tests.dbo.employees (first_name, last_name)" > /dev/null ) \
|& tee /results/indexing/employees.txt