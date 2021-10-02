#! /bin/bash

count=15

mkdir -p /results/
/skrypty/insert/timing/insert_timing.sh "before_index" "$count" |& tee /results/timing_before_idx.txt
/skrypty/insert/timing/insert_timing.sh "after_index" "$count" |& tee /results/timing_after_idx.txt