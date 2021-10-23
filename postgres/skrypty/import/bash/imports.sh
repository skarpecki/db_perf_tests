#! /bin/bash

count=$1
create_script="/skrypty/import/sql/create_all.sql"
truncate_script="/skrypty/import/sql/truncate_all.sql"

psql --username "postgres" -c "CREATE DATABASE perf_tests;"
psql --username "postgres" -f "$create_script"
for i in $(seq 0 $count)
do
    echo "Inports iteration: $i"
    for import_script in /skrypty/import/sql/imports/*.sql
    do
        script_name=$(basename $import_script .sql)
        results_path='/results/import/'"$script_name"
        
        mkdir -p "$results_path"
        if [[ "$i" -eq "0" ]] 
        then
            psql --username "postgres" -f "$import_script"
        else
            ( time psql --username "postgres" -f "$import_script" > /dev/null ) |& tee "$results_path"'/'"$i"'.txt'
        fi
    done
    psql --username "postgres" -f "$truncate_script" 
done