#! /bin/bash

count=21
for script in ../sql/selects/*.sql
do
script_name=$(basename $script .sql)
mkdir -p /results/selects/$1/$2/$script_name/
    for i in $(seq 0 $count)
    do
        if [[ "$i" -eq "0" ]] 
        then
            /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -i $script
        else
            echo $1 $2 $i
            ( time /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -i $script > /dev/null ) |& tee /results/selects/$1/$2/$script_name/$i.txt
        fi
    done
done

