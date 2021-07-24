#! /bin/bash

count=21

./select_some.sh "employees" "before_index" $count
./employees_indexing.sh
./select_some.sh "employees" "after_index" $count

./select_some.sh "addresses" "before_index" $count
./addresses_indexing.sh
./select_some.sh "addresses" "after_index" $count

./select_some.sh "companies" "before_index" $count
./companies_indexing.sh
./select_some.sh "companies" "after_index" $count

./select_some.sh "departments" "before_index" $count
./departments_indexing.sh
./select_some.sh "departments" "after_index" $count