#! /bin/bash

if [[ $# -lt 2 ]] ; then
    echo 'No arguments provided!'
    exit 0
fi


count=$1
cpus=$2

cpus_path='results_'"$cpus"'cpus'
results_path='/home/oracle/results/create/'"$cpus_path"'/results'

mkdir -p "$results_path"
/skrypty/create/timing/create_timing.sh $count $cpus |& tee "$results_path"'/create.txt'