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
        create_index='CREATE INDEX IX_clients'"$val"' ON clients'"$val"' (first_name, last_name);'
        drop_index='DROP INDEX IX_clients'"$val"';'
        results_path='/results/index/clients'"$val"
        mkdir -p "$results_path"

        if [[ "$i" -eq "0" ]]
        then
            psql --username "postgres" --dbname "perf_tests" -c "$create_index"
        else
            ( time psql --username "postgres" --dbname "perf_tests" \
                -c "$create_index" > /dev/null ) \
                |& tee "$results_path"'/'"$i"'.txt'
        fi
        psql --username "postgres" --dbname "perf_tests" -c "$drop_index"
    done
done