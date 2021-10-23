#! /bin/bash

for pow in $(seq 0 7)
do
    if [[ "$pow" -ne "7" ]]
    then
        val="_$(( 10 ** $pow ))"
    else
        val=""
    fi

    create_index='CREATE INDEX IX_clients'"$val"' ON perf_tests.clients'"$val"' (first_name, last_name);'
    echo "$create_index" | sqlplus PERF_TESTS/password@ORCLPDB1 

done