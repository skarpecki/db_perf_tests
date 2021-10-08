#! /bin/bash

was_indexed=$1
count=$2

cpus_path='results_'"$cpus"'cpus'
results_base='/home/oracle/results/insert/'"$cpus_path"'/results/index/clients'"$val"

results_path="$results_base"'/insert/'"$was_indexed"
mkdir -p "$results_path"
mkdir -p "$results_base"'/create'
mkdir -p "$results_base"'/import'
mkdir -p "$results_base"'/index'
mkdir -p "$results_base"'/drop'

for i in $(seq 0 $count)
do
    echo "Insert iteration no $i"
    /skrypty/insert/bash/create.sh |& tee "$results_base"'/create/creates_'"$i"'.txt'
    /skrypty/insert/bash/import.sh |& tee "$results_base"'/import/imports_'"$i"'.txt'
    if [[ "$was_indexed" == "after_index" ]]
    then
        /skrypty/insert/bash/clients_indexing.sh |& tee "$results_base"'/index/index_'"$i"'.txt'
    fi
    ( time /skrypty/insert/bash/insert.sh ) |& tee "$results_path"'/'"$i"'.txt'
    /skrypty/insert/bash/drop.sh |& tee "$results_base"'/drop/drop_'"$i"'.txt'
done