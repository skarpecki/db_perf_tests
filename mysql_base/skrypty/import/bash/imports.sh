#! /bin/bash

count=$1
create_script="/skrypty/import/sql/create_all.sql"
truncate_script="/skrypty/import/sql/truncate_all.sql"

mysql -u "root" -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS perf_tests;" > /dev/null
for i in $(seq 0 $count)
do
    for import_script in /skrypty/import/sql/imports/*.sql
    do
        echo "Inports iteration: $i"
        script_name=$(basename $import_script .sql)
        results_path='/results/import/'"$script_name"
        mysql -u "root" -p$MYSQL_ROOT_PASSWORD < "$create_script"
        
        mkdir -p "$results_path"
        if [[ "$i" -eq "0" ]] 
        then
            mysql -u "root" -p$MYSQL_ROOT_PASSWORD < "$import_script"
        else
            ( time mysql -u "root" -p$MYSQL_ROOT_PASSWORD < "$import_script" > /dev/null ) |& tee "$results_path"'/'"$i"'.txt'
        fi
        mysql -u "root" -p$MYSQL_ROOT_PASSWORD < $truncate_script 
    done
done