#! /bin/bash


for script in /skrypty/joins/sql/imports/*.sql
do
script_name=$(basename $script .sql)
mkdir -p /results/import
    /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P  $SA_PASSWORD -i $script |& tee /results/import/$script_name.txt
done