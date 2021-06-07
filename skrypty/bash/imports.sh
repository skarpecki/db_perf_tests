#! /bin/bash


for script in ../sql/imports/*.sql
do
script_name=$(basename $script .sql)
mkdir -p /results/imports/$script_name/
    ( time /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -i $script > /dev/null ) |& tee /results/imports/$script_name.txt
done