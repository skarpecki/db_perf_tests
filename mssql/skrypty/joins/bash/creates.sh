#! /bin/bash

mkdir -p /results/create/
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P  $SA_PASSWORD -Q "CREATE DATABASE perf_tests;" 
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P  $SA_PASSWORD -i /skrypty/joins/sql/create_all.sql 

