#! /bin/bash

/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD \
-Q "CREATE NONCLUSTERED INDEX IX_clients ON perf_tests.dbo.clients (first_name, last_name);" ) 

for i in $(seq 0 6)
do
    val=$(( 10 ** i ))
    /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD  \
    -Q "CREATE NONCLUSTERED INDEX IX_clients ON perf_tests.dbo.clients_$val (first_name, last_name);" 
done

