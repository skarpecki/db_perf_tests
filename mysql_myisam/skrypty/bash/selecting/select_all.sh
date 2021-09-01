#! /bin/bash

declare -a arr=( 
                "$1_base_all.sql"
                'one_join.sql' 
                'two_joins.sql'
                'three_joins.sql'
                )
path='/skrypty/sql/selects/'
count=$3

for script_name in "${arr[@]}"
do
script="${path}$script_name"
mkdir -p /results/selects/$1/$2/$script_name/
    for i in $(seq 0 $count)
    do
        if [[ "$i" -eq "0" ]] 
        then
            time mysql -u 'root' -p$MYSQL_ROOT_PASSWORD < $script  | head -n 10
        else
            echo $script_name $1 $2 $i
            ( time mysql -u 'root' -p$MYSQL_ROOT_PASSWORD < $script > /dev/null ) |& tee /results/selects/$1/$2/$script_name/$i.txt
        fi
    done
done

