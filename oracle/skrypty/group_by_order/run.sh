#! /bin/bash

if [[ $# -lt 2 ]] ; then
    echo 'No arguments provided!'
    exit 0
fi

count=$1
cpus=$2

cpus_path='results_'"$cpus"'cpus'
results_path='/home/oracle/results/group_by_order/'"$cpus_path"'/results'
mkdir -p $results_path

/skrypty/group_by_order/bash/create.sh |& tee "$results_path"'/creates.txt'
/skrypty/group_by_order/bash/import.sh $cpus |& tee "$results_path"'/imports.txt'
/skrypty/group_by_order/timing/select_timing.sh $count $cpus |& tee "$results_path"'/timing.txt'
