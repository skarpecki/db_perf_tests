#! /bin/bash

count=15
results_path="/home/oracle/results"
mkdir -p $results_path

/skrypty/insert/timing/insert_timing.sh "before_index" "$count" |& tee "$results_path"'/timing.txt'
/skrypty/insert/timing/insert_timing.sh "after_index" "$count" |& tee "$results_path"'/timing.txt'