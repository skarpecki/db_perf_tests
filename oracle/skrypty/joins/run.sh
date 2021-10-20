#! /bin/bash

cpus=$1
count=$2
cpus_path='results_'"$cpus"'cpus'
results_path='/home/oracle/results/joins/'"$cpus_path"'/results'
mkdir -p "$results_path"

/skrypty/joins/bash/create.sh                       |& tee "$results_path"'/creates.txt'
/skrypty/joins/bash/import.sh $cpus                 |& tee "$results_path"'/imports.txt'
/skrypty/joins/timing/select_timing.sh $cpus $count |& tee "$results_path"'/timing.txt'
