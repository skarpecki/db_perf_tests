#! /bin/bash

if [[ $# -lt 2 ]] ; then
    echo 'No arguments provided!'
    exit 0
fi

count=$1
cpus=$2

cpus_path='results_'"$cpus"'cpus'
results_path='/home/oracle/results/index/'"$cpus_path"'/results'

mkdir -p "$results_path"

/skrypty/index/bash/create.sh |& tee "$results_path"'/creates.txt'
/skrypty/index/bash/import.sh $cpus |& tee "$results_path"'/imports.txt'
/skrypty/index/timing/index_timing.sh $count $cpus |& tee "$results_path"'/timing.txt'