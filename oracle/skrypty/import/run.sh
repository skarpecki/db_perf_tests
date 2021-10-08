#! /bin/bash

cpus_path='results_'"$cpus"'cpus'
results_path='/home/oracle/results/import/'"$cpus_path"'/results'

count=15
mkdir -p /home/oracle/results/
/skrypty/import/timing/import_timing.sh $count |& tee "$results_path"'/import.txt'