#! /bin/bash

count=21

/skrypty/log/bash/select_log.sh "before_index" $count
/skrypty/log/bash/clients_indexing.sh
/skrypty/log/bash/select_log.sh "after_index" $count