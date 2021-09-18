#! /bin/bash

mkdir -p /results/index
( time /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD \
-Q "CREATE NONCLUSTERED INDEX IX_companies ON perf_tests.dbo.companies (name, sector)" ) \
|& tee /results/index/companies.txt