#! /bin/bash

was_indexed=$1
count=$2
results_path="/results/inserts/$was_indexed"
mkdir -p "$results_path"
mkdir -p '/results/creates'
mkdir -p '/results/imports'
mkdir -p '/results/index'
mkdir -p '/results/drops'

for i in $(seq 0 $count)
do
    echo "Insert iteration no $i"
    /skrypty/insert/bash/creates.sh |& tee '/results/creates/creates_'"$i"'.txt'
    /skrypty/insert/bash/imports.sh |& tee '/results/imports/imports_'"$i"'.txt'
    if [[ "$was_indexed" == "after_index" ]]
    then
        /skrypty/insert/bash/clients_indexing.sh |& tee '/results/index/index_'"$i"'.txt'
    fi
    ( time /skrypty/insert/bash/insert.sh ) |& tee "$results_path"'/'"$i"'.txt'
    /skrypty/insert/bash/drop.sh |& tee '/results/drops/drop_'"$i"'.txt'
done