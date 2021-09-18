#! /bin/bash


for script in /skrypty/log/sql/imports/*.sql
do
script_name=$(basename $script .sql)
mkdir -p /results/import
    ( time mysql -u "root" -p$MYSQL_ROOT_PASSWORD < $script &> /dev/null ) |& tee /results/import/$script_name.txt
done