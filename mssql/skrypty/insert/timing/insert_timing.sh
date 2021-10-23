#! /bin/bash

was_indexed=$1
count=$2
results_path="/results/insert/$was_indexed"
mkdir -p "$results_path"
mkdir -p '/results/create'
mkdir -p '/results/import'
mkdir -p '/results/index'
mkdir -p '/results/drop'

for i in $(seq 1 $count)
do
    echo "Insert iteration no $i"
    /skrypty/insert/bash/creates.sh |& tee '/results/create/creates_'"$i"'.txt'
    /skrypty/insert/bash/imports.sh |& tee '/results/import/imports_'"$i"'.txt'
    if [[ "$was_indexed" == "after_index" ]]
    then
        /skrypty/insert/bash/clients_indexing.sh |& tee '/results/index/index_'"$i"'.txt'
    fi
    ( time /skrypty/insert/bash/insert.sh ) |& tee "$results_path"'/'"$i"'.txt'
    /skrypty/insert/bash/drop.sh |& tee '/results/drop/drop_'"$i"'.txt'
done