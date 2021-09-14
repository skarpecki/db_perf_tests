#! /bin/bash

count=$1
create_script="/skrypty/import/sql/create_all.sql"
truncate_script="/skrypty/import/sql/truncate_all.sql"

/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -Q "CREATE DATABASE perf_tests;" > /dev/null
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -i "$create_script"

for i in $(seq 0 $count)
do
    for import_script in /skrypty/import/sql/imports/*.sql
    do
        echo "Inports iteration: $i"
        script_name=$(basename $import_script .sql)
        results_path='/results/import/'"$script_name"
        
        mkdir -p "$results_path"
        if [[ "$i" -eq "0" ]] 
        then
            /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -i "$import_script"
        else
            ( time /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -i "$import_script" > /dev/null ) |& tee "$results_path"'/'"$i"'.txt'
        fi
        /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -i $truncate_script 
    done
done