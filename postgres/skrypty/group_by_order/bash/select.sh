#! /bin/bash

selects_path="/skrypty/group_by_order/sql/selects"
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
        echo "Group by iteration: $i"
        if [[ "$i" -eq "0" ]] 
        then
            psql --username "postgres" --dbname "perf_tests" -f $script  | head -n 20
        else
            echo $script_name $was_indexed $i
            ( time psql --username "postgres" --dbname "perf_tests" -f $script > /dev/null ) \
             |& tee $results_path/$i.txt
        fi
    done
done
