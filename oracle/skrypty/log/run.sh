#!/bin/bash

mkdir -p ~/results
/skrypty/log/bash/create.sh |& tee ~/results/creates.txt
/skrypty/log/bash/import.sh |& tee ~/results/creates.txt
/skrypty/log/bash/select_log.sh |& tee ~/results/selects.txt