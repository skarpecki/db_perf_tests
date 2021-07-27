#! /bin/bash

count=21

./select_some.sh "clients" "before_index" $count
./clients_indexing.sh
./select_some.sh "clients" "after_index" $count

./select_some.sh "cities" "before_index" $count
./cities_indexing.sh
./select_some.sh "cities" "after_index" $count

./select_some.sh "companies" "before_index" $count
./companies_indexing.sh
./select_some.sh "companies" "after_index" $count

./select_some.sh "departments" "before_index" $count
./departments_indexing.sh
./select_some.sh "departments" "after_index" $count

./select_some.sh "orders" "before_index" $count
./orders_indexing.sh
./select_some.sh "orders" "after_index" $count