#! /bin/bash

count=2

mkdir -p /results/
/skrypty/joins/bash/creates.sh |& tee /results/creates.txt
/skrypty/joins/bash/imports.sh |& tee /results/imports.txt
/skrypty/joins/timing/select_timing.sh $count |& tee /results/timing.txt
