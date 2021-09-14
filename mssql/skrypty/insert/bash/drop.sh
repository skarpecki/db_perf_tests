#! /bin/bash

drop_statement="DROP TABLE perf_tests.dbo.clients;"
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P  $SA_PASSWORD -Q "$drop_statement"