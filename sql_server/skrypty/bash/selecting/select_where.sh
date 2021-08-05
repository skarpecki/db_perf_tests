#! /bin/bash

declare -a arr=( 
                "$1_base_where.sql"
                'one_join_where.sql'
                'two_joins_where.sql'
                'three_joins_where.sql'
                )
path='../sql/selects/'
count=$3

for script_name in "${arr[@]}"
do
script="${path}$script_name"
mkdir -p /results/selects/$1/$2/$script_name/
    for i in $(seq 0 $count)
    do
        if [[ "$i" -eq "0" ]] 
        then
            /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -i $script  | head -n 10
        else
            echo $script_name $1 $2 $i
            ( time /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -i $script > /dev/null ) |& tee /results/selects/$1/$2/$script_name/$i.txt
        fi
    done
done

