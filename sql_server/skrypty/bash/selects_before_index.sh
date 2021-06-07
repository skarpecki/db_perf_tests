#! /bin/bash

me=$(basename $0)
for script in ../sql/selects/*.sql
do
script_name=$(basename $script .sql)
mkdir -p /results/selects/$1/before_index/$script_name/
    for i in {1..5}
    do
        ( time /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -i $script > /dev/null ) |& tee /results/selects/$1/before_index/$script_name/$i.txt
    done
done