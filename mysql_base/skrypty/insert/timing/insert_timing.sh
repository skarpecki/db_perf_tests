#! /bin/bash

was_indexed=$1
count=$2
results_path="/results/inserts/$was_indexed"
mkdir -p "$results_path"

for i in $(seq 0 $count)
do

    /skrypty/insert/bash/creates.sh |& tee '/results/creates_'"$i"'.txt'
    /skrypty/insert/bash/imports.sh |& tee '/results/imports_'"$i"'.txt'
    if [[ "$was_indexed" == "after_index" ]]
    then
        echo "Indexing"
        /skrypty/insert/bash/clients_indexing.sh |& tee '/results/index_'"$i"'.txt'
    fi
    echo "Inserting"
    echo ""
    ( time /skrypty/insert/bash/insert.sh ) |& tee "$results_path"'/'"$i"
    /skrypty/insert/bash/drop.sh |& tee '/results/drop_'"$i"'.txt'
done