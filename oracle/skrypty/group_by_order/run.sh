#! /bin/bash

count=2
results_path=/home/oracle/results/
mkdir -p $results_path

/skrypty/group_by_order/bash/create.sh |& tee "$results_path"'/creates.txt'
/skrypty/group_by_order/bash/import.sh |& tee "$results_path"'/imports.txt'
/skrypty/group_by_order/timing/select_timing.sh $count |& tee "$results_path"'/timing.txt'
