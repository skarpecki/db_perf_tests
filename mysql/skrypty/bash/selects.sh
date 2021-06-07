#! /bin/bash

./selects_before_index.sh "employees"
./employees_indexing.sh
./selects_after_index.sh "employees"

./selects_before_index.sh "addresses"
./addresses_indexing.sh
./selects_after_index.sh "addresses"

./selects_before_index.sh "companies"
./companies_indexing.sh
./selects_after_index.sh "companies"

./selects_before_index.sh "departments"
./departments_indexing.sh
./selects_after_index.sh "departments"