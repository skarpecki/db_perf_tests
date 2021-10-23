#!/bin/bash


base_path="/home/dev/praca_inz/db_perf_tests/oracle"
test_type="log"
cpu="4"
container="oracle_srvr"

results_path="$base_path"'/results/'"$test_type"'/results_'"$cpu"'cpus'
mkdir -p "$results_path"
docker cp "$container"':/home/oracle/results' "$results_path"
