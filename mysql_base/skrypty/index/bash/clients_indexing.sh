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
        create_index='CREATE INDEX IX_clients ON perf_tests.clients'"$val"' (first_name, last_name);'
        drop_index='DROP INDEX IX_clients ON perf_tests.clients'"$val"';'
        results_path='/results/index/clients'"$val"
        mkdir -p "$results_path"

        if [[ "$i" -eq "0" ]]
        then
            mysql -u 'root' -p$MYSQL_ROOT_PASSWORD \
                -e "$create_index"
        else
            ( time mysql -u 'root' -p$MYSQL_ROOT_PASSWORD \
                -e "$create_index" ) \
                |& tee "$results_path"'/'"$i"'.txt'
        fi
        mysql -u 'root' -p$MYSQL_ROOT_PASSWORD \
            -e "$drop_index"
    done
done