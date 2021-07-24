#! /bin/bash

count=21

./select_where.sh "employees" "before_index" $count
./employees_indexing.sh
./select_where.sh "employees" "after_index" $count

./select_where.sh "addresses" "before_index" $count
./addresses_indexing.sh
./select_where.sh "addresses" "after_index" $count

./select_where.sh "companies" "before_index" $count
./companies_indexing.sh
./select_where.sh "companies" "after_index" $count

./select_where.sh "departments" "before_index" $count
./departments_indexing.sh
./select_where.sh "departments" "after_index" $count