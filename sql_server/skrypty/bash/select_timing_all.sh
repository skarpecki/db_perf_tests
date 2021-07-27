#! /bin/bash

count=6

./select_all.sh "employees" "before_index" $count
./employees_indexing.sh
./select_all.sh "employees" "after_index" $count

./select_all.sh "addresses" "before_index" $count
./addresses_indexing.sh
./select_all.sh "addresses" "after_index" $count

./select_all.sh "companies" "before_index" $count
./companies_indexing.sh
./select_all.sh "companies" "after_index" $count

./select_all.sh "departments" "before_index" $count
./departments_indexing.sh
./select_all.sh "departments" "after_index" $count

./select_all.sh "orders" "before_index" $count
./orders_indexing.sh
./select_all.sh "orders" "after_index" $count