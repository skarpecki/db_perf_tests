#! /bin/bash

count=6

/skrypty/bash/selecting/select_all.sh "clients" "before_index" $count
/skrypty/bash/indexing/clients_indexing.sh
/skrypty/bash/select_all.sh "clients" "after_index" $count

/skrypty/bash/select_all.sh "cities" "before_index" $count
/skrypty/bash/indexing/cities_indexing.sh
/skrypty/bash/selecting/select_all.sh "cities" "after_index" $count

/skrypty/bash/selecting/select_all.sh "companies" "before_index" $count
/skrypty/bash/indexing/companies_indexing.sh
/skrypty/bash/selecting/select_all.sh "companies" "after_index" $count

/skrypty/bash/selecting/select_all.sh "departments" "before_index" $count
/skrypty/bash/indexing/departments_indexing.sh
/skrypty/bash/selecting/select_all.sh "departments" "after_index" $count

/skrypty/bash/selecting/select_all.sh "orders" "before_index" $count
/skrypty/bash/indexing/orders_indexing.sh
/skrypty/bash/selecting/select_all.sh "orders" "after_index" $count