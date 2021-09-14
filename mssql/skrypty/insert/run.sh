#! /bin/bash

count=1

mkdir -p /results/
/skrypty/insert/timing/insert_timing.sh "before_index" "$count" |& tee /results/timing.txt
/skrypty/insert/timing/insert_timing.sh "after_index" "$count" |& tee /results/timing.txt