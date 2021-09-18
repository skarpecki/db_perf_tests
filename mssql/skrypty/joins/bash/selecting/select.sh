#! /bin/bash

declare -a scripts_names=( 
                'one_join.sql' 
                'one_join_where.sql'
                'two_joins.sql'
                'two_joins_where.sql'
                'three_joins.sql'
                'three_joins_where.sql'
                )
scripts_path='/skrypty/joins/sql/selects/'
indexed_table=$1
was_indexed=$2
count=$3

for script_name in "${scripts_names[@]}"
do
    results_path="/results/selects/$indexed_table/$was_indexed/$script_name"
    script="${scripts_path}$script_name"
    mkdir -p $results_path
    for i in $(seq 0 $count)
    do
        echo "Joins iteration no $i"
        if [[ "$i" -eq "0" ]] 
        then
            /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P  $SA_PASSWORD -i $script | head -n 10
        else
            echo $script_name $indexed_table $was_indexed $i
            ( time /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P  $SA_PASSWORD -i $script > /dev/null ) |& tee $results_path/$i.txt
        fi
    done
done