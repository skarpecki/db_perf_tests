#! /bin/bash

mkdir -p /results/indexing
( time /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD \
-Q "CREATE NONCLUSTERED INDEX IX_companies ON perf_tests.dbo.companies (name, sector)" > /dev/null ) \
|& tee /results/indexing/companies.txt