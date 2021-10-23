#! /bin/bash

selects_path="/skrypty/window_function/sql/selects"
count=$2

for script in $selects_path/*.sql
do
script_name=$(basename $script .sql)
was_indexed=$1
indexed_table=$script_name
results_path="/results/select/$indexed_table/$was_indexed/$script_name"
mkdir -p $results_path
    for i in $(seq 0 $count)
    do
        echo "Window function iteration: $i"
        if [[ "$i" -eq "0" ]] 
        then
            mysql -u "root" -p$MYSQL_ROOT_PASSWORD < $script  | head -n 10
        else
            echo $script_name $was_indexed $i
            ( time mysql -u "root" -p$MYSQL_ROOT_PASSWORD < $script &> /dev/null ) |& tee $results_path/$i.txt
        fi
    done
done
