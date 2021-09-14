#! /bin/bash

count=6

../selecting/select_all.sh "clients" "before_index" $count
../selecting/clients_indexing.sh
../selecting/select_all.sh "clients" "after_index" $count

../selecting/select_all.sh "cities" "before_index" $count
../selecting/cities_indexing.sh
../selecting/select_all.sh "cities" "after_index" $count

../selecting/select_all.sh "companies" "before_index" $count
../selecting/companies_indexing.sh
../selecting/select_all.sh "companies" "after_index" $count

../selecting/select_all.sh "departments" "before_index" $count
../selecting/departments_indexing.sh
../selecting/select_all.sh "departments" "after_index" $count

../selecting/select_all.sh "orders" "before_index" $count
../selecting/orders_indexing.sh
../selecting/select_all.sh "orders" "after_index" $count