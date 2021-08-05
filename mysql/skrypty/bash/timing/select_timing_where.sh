#! /bin/bash

count=21

../selecting/select_where.sh "clients" "before_index" $count
../selecting/clients_indexing.sh
../selecting/select_where.sh "clients" "after_index" $count

../selecting/select_where.sh "cities" "before_index" $count
../selecting/cities_indexing.sh
../selecting/select_where.sh "cities" "after_index" $count

../selecting/select_where.sh "companies" "before_index" $count
../selecting/companies_indexing.sh
../selecting/select_where.sh "companies" "after_index" $count

../selecting/select_where.sh "departments" "before_index" $count
../selecting/departments_indexing.sh
../selecting/select_where.sh "departments" "after_index" $count

../selecting/select_where.sh "orders" "before_index" $count
../selecting/orders_indexing.sh
../selecting/select_where.sh "orders" "after_index" $count