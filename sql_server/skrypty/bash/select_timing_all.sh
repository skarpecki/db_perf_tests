#! /bin/bash

count=6

./select_all.sh "clients" "before_index" $count
./clients_indexing.sh
./select_all.sh "clients" "after_index" $count

./select_all.sh "cities" "before_index" $count
./cities_indexing.sh
./select_all.sh "cities" "after_index" $count

./select_all.sh "companies" "before_index" $count
./companies_indexing.sh
./select_all.sh "companies" "after_index" $count

./select_all.sh "departments" "before_index" $count
./departments_indexing.sh
./select_all.sh "departments" "after_index" $count

./select_all.sh "orders" "before_index" $count
./orders_indexing.sh
./select_all.sh "orders" "after_index" $count