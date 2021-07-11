#! /bin/bash

mkdir -p /results/indexing
count=20
path_base=/results/indexing

for i in $(seq 1 $count)
do
mkdir -p $path_base/addresses/
( time /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD \
-Q "CREATE NONCLUSTERED INDEX IX_addresses ON perf_tests.dbo.addresses (city)" > /dev/null ) \
|& tee $path_base/addresses/$i.txt
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -Q "USE perf_tests; DROP INDEX dbo.addresses.IX_addresses;" > /dev/null 
done



for i in $(seq 1 $count)
do
mkdir -p $path_base/companies/
( time /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD \
-Q "CREATE NONCLUSTERED INDEX IX_companies ON perf_tests.dbo.companies (name, sector)" > /dev/null ) \
|& tee $path_base/companies/$i.txt
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -Q "USE perf_tests; DROP INDEX dbo.companies.IX_companies;" > /dev/null
done


for i in $(seq 1 $count)
do
mkdir -p $path_base/departments/
( time /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD \
-Q "CREATE NONCLUSTERED INDEX IX_departments ON perf_tests.dbo.departments (name)" > /dev/null ) \
|& tee $path_base/departments/$i.txt
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -Q "USE perf_tests; DROP INDEX dbo.departments.IX_departments;" > /dev/null
done


for i in $(seq 1 $count)
do
mkdir -p $path_base/employees/
( time /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD \
-Q "CREATE NONCLUSTERED INDEX IX_employees ON perf_tests.dbo.employees (first_name, last_name)" > /dev/null ) \
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -Q "USE perf_tests; DROP INDEX dbo.employees.IX_employees;" > /dev/null
|& tee $path_base/employees/$i.txt
done