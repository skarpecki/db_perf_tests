#!/bin/bash

declare -a tests_types=(
  #  "create"
  #  "import"
    "index"
  #  "insert"
  #  "joins"
  #  "log"
  #  "group_by_order"
)

declare -a cpus=(
    # 1
    2  
    # 4
)

base_path="/home/dev/praca_inz/db_perf_tests/postgres"
container="postgres_srvr"
for test_type in ${tests_types[@]}
do
    echo 'Testing '"$test_type"
    for cpu in ${cpus[@]}
    do
        echo 'Testing with cpus: '"$cpu"
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
