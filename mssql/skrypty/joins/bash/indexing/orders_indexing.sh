#! /bin/bash

mkdir -p /results/indexing
( time /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD \
-Q "CREATE NONCLUSTERED INDEX IX_orders ON perf_tests.dbo.orders (part_num)" ) \
|& tee /results/indexing/departments.txt