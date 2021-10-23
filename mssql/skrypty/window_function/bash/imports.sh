#! /bin/bash


for script in /skrypty/window_function/sql/imports/*.sql
do
    /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P  $SA_PASSWORD -i $script
done