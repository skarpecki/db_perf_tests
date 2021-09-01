#! /bin/bash

count=21

/skrypty/bash/selecting/select_where.sh "clients" "before_index" $count
/skrypty/bash/indexing/clients_indexing.sh
/skrypty/bash/selecting/select_where.sh "clients" "after_index" $count

/skrypty/bash/selecting/select_where.sh "cities" "before_index" $count
/skrypty/bash/indexing/cities_indexing.sh
/skrypty/bash/selecting/select_where.sh "cities" "after_index" $count

/skrypty/bash/selecting/select_where.sh "companies" "before_index" $count
/skrypty/bash/indexing/companies_indexing.sh
/skrypty/bash/selecting/select_where.sh "companies" "after_index" $count

/skrypty/bash/selecting/select_where.sh "departments" "before_index" $count
/skrypty/bash/indexing/departments_indexing.sh
/skrypty/bash/selecting/select_where.sh "departments" "after_index" $count

/skrypty/bash/selecting/select_where.sh "orders" "before_index" $count
/skrypty/bash/indexing/orders_indexing.sh
/skrypty/bash/selecting/select_where.sh "orders" "after_index" $count