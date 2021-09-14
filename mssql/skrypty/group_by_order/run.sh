#! /bin/bash

count=1
mkdir -p /results/
/skrypty/group_by_order/bash/creates.sh |& tee /results/creates.txt
/skrypty/group_by_order/bash/imports.sh |& tee /results/imports.txt
/skrypty/group_by_order/timing/select_timing.sh $count |& tee /results/timing.txt
