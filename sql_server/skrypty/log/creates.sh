#! /bin/bash

mkdir -p /results/creates/
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P  $SA_PASSWORD -Q "IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'perf_tests') BEGIN CREATE DATABASE perf_tests END" > /dev/null
( time /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P  $SA_PASSWORD -i /skrypty/log/sql/create_all.sql  > /dev/null ) |& tee /results/creates/creates.txt
