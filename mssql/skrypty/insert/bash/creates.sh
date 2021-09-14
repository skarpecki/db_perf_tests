#! /bin/bash

mkdir -p /results/creates/
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P  $SA_PASSWORD -Q "CREATE DATABASE perf_tests;" > /dev/null
( time /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P  $SA_PASSWORD -i /skrypty/insert/sql/create.sql  > /dev/null ) |& tee /results/creates/creates.txt