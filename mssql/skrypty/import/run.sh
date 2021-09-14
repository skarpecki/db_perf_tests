#! /bin/bash

count=1
mkdir -p /results/
/skrypty/import/timing/import_timing.sh $count |& tee /results/imports.txt
