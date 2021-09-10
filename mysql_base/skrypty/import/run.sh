#! /bin/bash

mkdir -p /results/
/skrypty/import/timing/import_timing.sh 2 |& tee /results/imports.txt
