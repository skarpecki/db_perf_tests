#! /bin/bash


for script in /skrypty/index/sql/import/*.sql
do
script_name=$(basename $script .sql)
mysql -u "root" -p$MYSQL_ROOT_PASSWORD < $script > /dev/null 
done