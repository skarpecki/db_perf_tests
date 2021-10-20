#! /bin/bash

count=$1
cpus=$2
results_path='/home/oracle/results/insert/'"$cpus_path"'/results'
mkdir -p $results_path

/skrypty/insert/timing/insert_timing.sh "before_index" "$count" "$cpus" |& tee "$results_path"'/timing_before_index.txt'
/skrypty/insert/timing/insert_timing.sh "after_index" "$count" "$cpus" |& tee "$results_path"'/timing_after_index.txt'
