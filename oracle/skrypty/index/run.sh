#! /bin/bash

count=1
results_path='/home/oracle/results'
mkdir -p "$results_path"

/skrypty/index/bash/create.sh |& tee "$results_path"'/creates.txt'
/skrypty/index/bash/import.sh |& tee "$results_path"'/imports.txt'
/skrypty/index/timing/index_timing.sh $count |& tee "$results_path"'/timing.txt'