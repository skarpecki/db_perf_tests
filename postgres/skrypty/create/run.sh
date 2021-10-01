#! /bin/bash

count=25
mkdir -p /results/
/skrypty/create/timing/create_timing.sh $count |& tee /results/creates.txt