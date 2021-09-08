#! /bin/bash

mkdir -p /results/
/skrypty/create_import/timing/create_timing.sh |& tee /results/creates.txt
/skrypty/create_import/timing/import_timing.sh |& tee /results/imports.txt
