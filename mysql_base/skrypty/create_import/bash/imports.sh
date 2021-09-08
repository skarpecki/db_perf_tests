#! /bin/bash

count=$1
results_path=/results/create_import/imports
create_script=/skrypty/create_import/sql/create_all.sql
truncate_script=/skrypty/create_import/sql/truncate_all.sql

mkdir -p "$results_path"
for import_script in /skrypty/create_import/sql/imports/*.sql
do
    script_name=$(basename $script .sql)
    for i in $(seq 0 $count)
    do
        if [[ "$i" -eq "0" ]] 
        then
            mysql -u "root" -p$MYSQL_ROOT_PASSWORD < $create_script > /dev/null
            mysql -u "root" -p$MYSQL_ROOT_PASSWORD < $import_script > /dev/null
        else
            ( time mysql -u "root" -p$MYSQL_ROOT_PASSWORD < $import_script > /dev/null ) |& tee $results_path/$script_name/$i.txt
        fi
        mysql -u "root" -p$MYSQL_ROOT_PASSWORD < $truncate_script > /dev/null
    done
done