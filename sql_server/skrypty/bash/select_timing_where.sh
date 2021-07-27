#! /bin/bash

count=21

./select_where.sh "clients" "before_index" $count
./employees_indexing.sh
./select_where.sh "clients" "after_index" $count

./select_where.sh "cities" "before_index" $count
./addresses_indexing.sh
./select_where.sh "cities" "after_index" $count

./select_where.sh "companies" "before_index" $count
./companies_indexing.sh
./select_where.sh "companies" "after_index" $count

./select_where.sh "departments" "before_index" $count
./departments_indexing.sh
./select_where.sh "departments" "after_index" $count

./select_where.sh "orders" "before_index" $count
./orders_indexing.sh
./select_where.sh "orders" "after_index" $count