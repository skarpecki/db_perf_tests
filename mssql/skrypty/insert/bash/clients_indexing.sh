#! /bin/bash

mkdir -p /results/index
(   /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P  $SA_PASSWORD \
-Q "CREATE NONCLUSTERED INDEX IX_clients ON perf_tests.dbo.clients (first_name, last_name);" ) \
|& tee /results/index/clients.txt

