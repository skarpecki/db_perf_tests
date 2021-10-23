#! /bin/bash


for script in /skrypty/group_by_order/sql/imports/*.sql
do
    script_name=$(basename $script .sql)
    /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P  $SA_PASSWORD -i $script
done