#! /bin/bash

if [[ $# -lt 2 ]] ; then
    echo 'No arguments provided!'
    exit 0
fi

count=$1
cpus=$2

cpus_path='results_'"$cpus"'cpus'
results_path='/home/oracle/results/window_function/'"$cpus_path"'/results'
mkdir -p $results_path

/skrypty/window_function/bash/create.sh |& tee "$results_path"'/creates.txt'
/skrypty/window_function/bash/import.sh $cpus |& tee "$results_path"'/imports.txt'
/skrypty/window_function/timing/select_timing.sh $count $cpus |& tee "$results_path"'/timing.txt'
