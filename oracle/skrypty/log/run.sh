#! /bin/bash

count=15

mkdir -p /results/
/skrypty/log/bash/creates.sh |& tee /results/creates.txt
/skrypty/log/bash/imports.sh |& tee /results/imports.txt
/skrypty/log/timing/select_timing_log.sh $count |& tee /results/timing.txt