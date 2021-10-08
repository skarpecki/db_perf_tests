#! /bin/bash

cpus_path='results_'"$cpus"'cpus'
results_path='/home/oracle/results/create/'"$cpus_path"'/results'

count=15
mkdir -p "$results_path"
/skrypty/create/timing/create_timing.sh $count |& tee "$results_path"'/create.txt'