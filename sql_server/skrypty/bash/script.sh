#! /bin/bash

./select.sh "employees" "before_index"
./employees_inserting.sh "before_index"
./employees_deleting.sh "before_index"
./employees_indexing.sh
./employees_inserting.sh "after_index"
./employees_deleting.sh "after_index"
./select.sh "employees" "after_index"

./select.sh "addresses" "before_index"
./addresses_indexing.sh
./select.sh "addresses" "after_index"

./select.sh "companies" "before_index"
./companies_indexing.sh
./select.sh "companies" "after_index"

./select.sh "departments" "before_index"
./departments_indexing.sh
./select.sh "departments" "after_index"