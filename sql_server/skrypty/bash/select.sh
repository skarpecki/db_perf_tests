#! /bin/bash

total=0
count=5
TIMEFORMAT="%R"
for script in ../sql/selects/*.sql
do
script_name=$(basename $script .sql)
mkdir -p /results/selects/$1/$2/$script_name/
    for i in $(seq 1 $count)
    do
        ( time /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -i $script > /dev/null ) 
    done
done

|& tee /results/selects/$1/$2/$script_name/$i.txt