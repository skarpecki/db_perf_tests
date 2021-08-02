#! /bin/bash

mkdir -p /results/indexing
( time /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD \
-Q "CREATE NONCLUSTERED INDEX IX_cities ON perf_tests.dbo.cities (city)" ) \
|& tee /results/indexing/addresses.txt