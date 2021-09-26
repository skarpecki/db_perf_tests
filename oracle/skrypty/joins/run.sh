#! /bin/bash

count=1
results_path='/home/oracle/results'
mkdir -p "$results_path"

/skrypty/joins/bash/creates.sh |& tee "$results_path"'/creates.txt'
/skrypty/joins/bash/imports.sh |& tee "$results_path"'/imports.txt'
/skrypty/joins/timing/select_timing.sh $count |& tee "$results_path"'/timing.txt'