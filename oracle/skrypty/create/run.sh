#! /bin/bash

count=15
mkdir -p ~/results/
/skrypty/create/timing/create_timing.sh $count |& tee /home/oracle/results/create.txt