#! /bin/bash

count=11
mkdir -p /results/
/skrypty/create/timing/create_timing.sh $count |& tee /results/creates.txt