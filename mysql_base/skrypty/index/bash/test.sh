#! /bin/bash


for pow in $(seq 0 7)
do
    if [[ "$pow" -ne "7" ]]
    then
        val="_$(( 10 ** $pow ))"
    else
        val=""
    fi
    create_index='CREATE INDEX IX_clients ON perf_tests.clients'"$val"' (first_name, last_name);'
    drop_index='DROP INDEX IX_clients ON perf_tests.clients'"$val"';'
    results_path='/results/indexing/clients'"$val"
    echo "$drop_index"
    
done