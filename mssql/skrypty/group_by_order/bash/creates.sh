#! /bin/bash

/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P  $SA_PASSWORD -Q "CREATE DATABASE perf_tests;" 
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P  $SA_PASSWORD -i /skrypty/group_by_order/sql/create_all.sql`