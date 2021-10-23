#! /bin/bash

count=$1

/skrypty/joins/bash/select.sh "clients" "before_index" $count
/skrypty/joins/bash/indexing/clients_indexing.sh
/skrypty/joins/bash/select.sh "clients" "after_index" $count

/skrypty/joins/bash/select.sh "cities" "before_index" $count
/skrypty/joins/bash/indexing/cities_indexing.sh
/skrypty/joins/bash/select.sh "cities" "after_index" $count

/skrypty/joins/bash/select.sh "companies" "before_index" $count
/skrypty/joins/bash/indexing/companies_indexing.sh
/skrypty/joins/bash/select.sh "companies" "after_index" $count 

/skrypty/joins/bash/select.sh "orders" "before_index" $count
/skrypty/joins/bash/indexing/orders_indexing.sh
/skrypty/joins/bash/select.sh "orders" "after_index" $count