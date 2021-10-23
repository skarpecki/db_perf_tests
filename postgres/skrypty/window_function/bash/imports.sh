#! /bin/bash


for script in /skrypty/window_function/sql/imports/*.sql
do
script_name=$(basename $script .sql)
mysql -u "root" -p$MYSQL_ROOT_PASSWORD < $script 
done