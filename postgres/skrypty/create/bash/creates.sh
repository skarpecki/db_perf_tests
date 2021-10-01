#! /bin/bash

results_path="/results/create"
mkdir -p "$results_path"
create_script="/skrypty/create/sql/create_all.sql"
drop_script="/skrypty/create/sql/drop_all.sql"

count=$1
psql --username "postgres" -c "CREATE DATABASE perf_tests;"
for i in $(seq 0 $count)
do
    echo "Creating iteration: $i"
    if [[ "$i" -eq "0" ]] 
    then
        psql --username "postgres" --dbname="perf_tests" -f $create_script 
    else
        ( time psql --username "postgres" --dbname="perf_tests" -f $create_script > /dev/null ) |& tee "$results_path"'/'"$i"'.txt'
    fi
    psql --username "postgres" --dbname="perf_tests" -f $drop_script 
done
