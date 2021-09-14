#! /bin/bash

mkdir -p /results/indexing
( time /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD \
-Q "CREATE NONCLUSTERED INDEX IX_clients ON perf_tests.dbo.clients (first_name, last_name);" ) \
|& tee /results/indexing/clients.txt

for i in $(seq 0 6)
do
    val=$(( 10 ** i ))
    ( time /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD \
    -Q "CREATE NONCLUSTERED INDEX IX_clients_$val ON perf_tests.dbo.clients_$val (first_name, last_name);" ) \
    |& tee /results/indexing/clients_$val.txt
done