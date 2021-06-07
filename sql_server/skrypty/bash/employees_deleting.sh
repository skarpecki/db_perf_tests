#! /bin/bash

mkdir -p /results/deleting/$1
( time /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -Q "DELETE FROM perf_tests.dbo.employees WHERE employee_id=1000001;" > /dev/null ) |& tee /results/deleting/$1/employees.txt