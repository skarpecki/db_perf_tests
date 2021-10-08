#! /bin/bash

cpus_path='results_'"$cpus"'cpus'
results_path='/home/oracle/results/index/'"$cpus_path"'/results'

mkdir -p "$results_path"

count=15
/skrypty/index/bash/create.sh |& tee "$results_path"'/creates.txt'
/skrypty/index/bash/import.sh |& tee "$results_path"'/imports.txt'
/skrypty/index/timing/index_timing.sh $count |& tee "$results_path"'/timing.txt'