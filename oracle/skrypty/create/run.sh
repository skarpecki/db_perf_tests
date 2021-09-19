#! /bin/bash

count=2
mkdir -p /results/
/skrypty/create/timing/create_timing.sh $count |& tee /results/create.txt