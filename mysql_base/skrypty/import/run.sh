#! /bin/bash

mkdir -p /results/
/skrypty/import/timing/import_timing.sh |& tee /results/imports.txt
