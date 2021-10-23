#! /bin/bash

cpus=$1
count=$2

/skrypty/log/bash/select.sh "before_index" $cpus $count
/skrypty/log/bash/clients_indexing.sh 
/skrypty/log/bash/select.sh "after_index" $cpus $count