#! /bin/bash

count=6

./select_some.sh "clients" "before_index" $count
./clients_indexing.sh
./select_some.sh "clients" "after_index" $count

./select_some.sh "cities" "before_index" $count
./cities_indexing.sh
./select_some.sh "cities" "after_index" $count

./select_some.sh "companies" "before_index" $count
./companies_indexing.sh
./select_some.sh "companies" "after_index" $count
