#! /bin/bash


for script in /skrypty/index/sql/imports/*.sql
do
    script_name=$(basename $script .sql)
    mkdir -p /results/import
        ( time /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P  $SA_PASSWORD -i $script > /dev/null ) |& tee /results/import/$script_name.txt
done