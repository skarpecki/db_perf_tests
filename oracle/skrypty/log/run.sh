#! /bin/bash

cpus=$1
count=$2
cpus_path='results_'"$cpus"'cpus'
results_path='/home/oracle/results/log/'"$cpus_path"'/results'

mkdir -p "$results_path"
/skrypty/log/bash/create.sh                    |& tee "$results_path"'/creates.txt'
/skrypty/log/bash/import.sh $cpus              |& tee "$results_path"'/imports.txt'
/skrypty/log/timing/log_timing.sh $cpus $count |& tee "$results_path"'/timing.txt'