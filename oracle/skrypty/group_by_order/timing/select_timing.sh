#! /bin/bash

count=$1
cpus=$2

/skrypty/group_by_order/bash/select.sh "before_index" $count $cpus
/skrypty/group_by_order/bash/clients_indexing.sh
/skrypty/group_by_order/bash/select.sh "after_index" $count $cpus