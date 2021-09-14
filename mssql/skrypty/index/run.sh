#! /bin/bash

count=11
mkdir -p /results/

/skrypty/index/bash/creates.sh |& tee /results/creates.txt
/skrypty/index/bash/imports.sh |& tee /results/imports.txt
/skrypty/index/timing/index_timing.sh $count |& tee /results/timing.txt