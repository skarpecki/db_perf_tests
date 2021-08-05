#! /bin/bash

count=21

../selecting/select_some.sh "clients" "before_index" $count
../selecting/clients_indexing.sh
../selecting/select_some.sh "clients" "after_index" $count

../selecting/select_some.sh "cities" "before_index" $count
../selecting/cities_indexing.sh
../selecting/select_some.sh "cities" "after_index" $count

../selecting/select_some.sh "companies" "before_index" $count
../selecting/companies_indexing.sh
../selecting/select_some.sh "companies" "after_index" $count

../selecting/select_some.sh "departments" "before_index" $count
../selecting/departments_indexing.sh
../selecting/select_some.sh "departments" "after_index" $count

../selecting/select_some.sh "orders" "before_index" $count
../selecting/orders_indexing.sh
../selecting/select_some.sh "orders" "after_index" $count