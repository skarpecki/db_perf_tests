#! /bin/bash

cpus=$1
count=$2

/skrypty/window_function/bash/select.sh "before_index" $cpus $count
# /skrypty/window_function/bash/clients_indexing.sh
# /skrypty/window_function/bash/select.sh "after_index" $count $cpus