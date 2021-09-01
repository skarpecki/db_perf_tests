#! /bin/bash

count=21

/skrypty/group_by_order/bash/select.sh "before_index" $count
/skrypty/group_by_order/bash/clients_indexing.sh
/skrypty/group_by_order/bash/select.sh "after_index" $count