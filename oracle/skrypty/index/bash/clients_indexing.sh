#! /bin/bash

count=$1

for pow in $(seq 0 7)
do
    if [[ "$pow" -ne "7" ]]
    then
        val="_$(( 10 ** $pow ))"
    else
        val=""
    fi

    for i in $(seq 0 $count)
    do
        echo "Indexing iteration: $i"
        create_index='CREATE INDEX IX_clients'"$val"' ON perf_tests.clients'"$val"' (first_name, last_name);'
        drop_index='DROP INDEX IX_clients'"$val"';'
        results_path='/home/oracle/results/index/clients'"$val"
        mkdir -p "$results_path"

        if [[ "$i" -eq "0" ]]
        then
            echo "$create_index" | sqlplus PERF_TESTS/password@ORCLPDB1 
        else
            ( time echo "$create_index" | sqlplus PERF_TESTS/password@ORCLPDB1 ) \
                |& tee "$results_path"'/'"$i"'.txt'
        fi
        echo "$drop_index" | sqlplus PERF_TESTS/password@ORCLPDB1
    done
done