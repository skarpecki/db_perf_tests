#! /bin/bash

results_path="/results/create"
mkdir -p "$results_path"
create_script="/skrypty/create/sql/create_all.sql"
drop_script="/skrypty/create/sql/drop_all.sql"

count=$1
mysql -u "root" -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS perf_tests;" > /dev/null
for i in $(seq 0 $count)
do
    echo "Creating iteration: $i"
    if [[ "$i" -eq "0" ]] 
    then
        mysql -u 'root' -p$MYSQL_ROOT_PASSWORD < $create_script 
    else
        ( time mysql -u "root" -p$MYSQL_ROOT_PASSWORD < $create_script &> /dev/null ) |& tee "$results_path"'/'"$i"'.txt'
    fi
    mysql -u 'root' -p$MYSQL_ROOT_PASSWORD < $drop_script 
done
