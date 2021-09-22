#! /bin/bash

count=2
mkdir -p ~/results/
/skrypty/import/timing/import_timing.sh $count |& tee ~/results/import.txt