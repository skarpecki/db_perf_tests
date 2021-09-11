#! /bin/bash


for script in /skrypty/group_by_order/sql/imports/*.sql
do
script_name=$(basename $script .sql)
mkdir -p /results/imports
    ( time mysql -u "root" -p$MYSQL_ROOT_PASSWORD < $script &> /dev/null ) |& tee /results/imports/$script_name.txt
done