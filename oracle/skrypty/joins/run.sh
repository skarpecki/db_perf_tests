#! /bin/bash

count=15
results_path='/home/oracle/joins/results'
mkdir -p "$results_path"

/skrypty/joins/bash/create.sh |& tee "$results_path"'/creates.txt'
/skrypty/joins/bash/import.sh |& tee "$results_path"'/imports.txt'
/skrypty/joins/timing/select_timing.sh $count |& tee "$results_path"'/timing.txt'
