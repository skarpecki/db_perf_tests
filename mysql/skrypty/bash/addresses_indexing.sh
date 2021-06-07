#! /bin/bash

mkdir -p /results/indexing
( time /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -Q "CREATE NONCLUSTERED INDEX IX_addresses ON perf_tests.dbo.addresses (city)" > /dev/null ) |& tee /results/indexing/addresses.txt