#! /bin/bash

selects_path="/skrypty/log/sql/selects"
count=$2

for script in $selects_path/*.sql
do
script_name=$(basename $script .sql)
was_indexed=$1
indexed_table="clients"
results_path="/results/selects/$indexed_table/$was_indexed/$script_name"
mkdir -p $results_path
    for i in $(seq 0 $count)
    do
        if [[ "$i" -eq "0" ]] 
        then
            mysql -u "root" -p$MYSQL_ROOT_PASSWORD < $script  | head -n 10
        else
            echo $script_name $1 $i
            ( time mysql -u "root" -p$MYSQL_ROOT_PASSWORD < $script &> /dev/null ) |& tee $results_path/$i.txt
        fi
    done
done
