#! /bin/bash

for pow in $(seq 0 7)
do
    if [[ "$pow" -ne "7" ]]
    then
        val="_$(( 10 ** $pow ))"
    else
        val=""
    fi
    create_index='CREATE INDEX IX_clients'"$val"' ON clients'"$val"' (first_name, last_name);'
    psql --username "postgres" --dbname "perf_tests" -c "$create_index"
done