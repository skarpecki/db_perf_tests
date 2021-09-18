#! /bin/bash

mkdir -p /results/create/
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P  $SA_PASSWORD -Q "CREATE DATABASE perf_tests;" > /dev/null
( time /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P  $SA_PASSWORD -i /skrypty/index/sql/create_all.sql  > /dev/null ) |& tee /results/create/creates.txt
