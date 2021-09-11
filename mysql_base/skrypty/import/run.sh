#! /bin/bash

count=21
mkdir -p /results/
/skrypty/import/timing/import_timing.sh $count |& tee /results/imports.txt
