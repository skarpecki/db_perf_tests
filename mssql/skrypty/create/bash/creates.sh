#! /bin/bash

results_path="/results/create"
mkdir -p "$results_path"
create_script="/skrypty/create/sql/create_all.sql"
drop_script="/skrypty/create/sql/drop_all.sql"

count=$1
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P  $SA_PASSWORD -Q "CREATE DATABASE perf_tests;" > /dev/null

for i in $(seq 0 $count)
do
    echo "Creating iteration: $i"
    if [[ "$i" -eq "0" ]] 
    then
        /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P  $SA_PASSWORD -i $create_script 
    else
        ( time /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P  $SA_PASSWORD -i $create_script > /dev/null ) |& tee "$results_path"'/'"$i"'.txt'
    fi
    /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P  $SA_PASSWORD -i $drop_script 
done
