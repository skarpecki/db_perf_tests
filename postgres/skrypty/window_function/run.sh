#! /bin/bash

count=15
mkdir -p /results/
/skrypty/window_function/bash/creates.sh |& tee /results/creates.txt
/skrypty/window_function/bash/imports.sh |& tee /results/imports.txt
/skrypty/window_function/timing/select_timing.sh $count |& tee /results/timing.txt
