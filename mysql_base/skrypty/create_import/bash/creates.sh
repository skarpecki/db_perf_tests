#! /bin/bash

mkdir -p /results/create_import/create
create_script=/skrypty/create_import/sql/create_all.sql
drop_script=/skrypty/create_import/sql/drop_all.sql

count=$1
mysql -u "root" -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS perf_tests;" > /dev/null
for i in $(seq 0 $count)
do
    if [[ "$i" -eq "0" ]] 
    then
        mysql -u 'root' -p$MYSQL_ROOT_PASSWORD < $create_script 
    else
        ( time mysql -u "root" -p$MYSQL_ROOT_PASSWORD < $create_script > /dev/null ) |& tee /results/create_import/create/$i.txt
    fi
    mysql -u 'root' -p$MYSQL_ROOT_PASSWORD < $drop_script 
done
