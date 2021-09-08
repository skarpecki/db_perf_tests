#!/bin/bash

declare -a tests_types=(
    "joins"
    "log"
    "group_by_order"
)

declare -a cpus=(
    1
    2  
    4
)

base_path="/home/dev/praca_inz/db_perf_tests/mysql_innodb"
container="mysql-innodb_srvr"
for test_type in ${tests_types[@]}
do
    for cpu in ${cpus[@]}
    do
        results_path="$base_path"'/'"$test_type"'/results_'"$cpu"'cpus'
        mkdir -p "$results_path"
        "$base_path"'/run.sh' "$cpu"
        sleep 30
        docker exec -it "$container" '/skrypty/'"$test_type"'/run.sh'
        sleep 5
        docker cp "$container"':/results' "$results_path"
        "$base_path"'/prune.sh'
    done
done