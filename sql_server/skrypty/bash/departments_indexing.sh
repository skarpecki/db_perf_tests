#! /bin/bash

mkdir -p /results/indexing
TIMEFORMAT="%R"
( time /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD \
-Q "CREATE NONCLUSTERED INDEX IX_departments ON perf_tests.dbo.departments (name)" > /dev/null ) \
|& tee /results/indexing/departments.txt