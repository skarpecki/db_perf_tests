#! /bin/bash

count=$1
cpus=$2

cpus_path='results_'"$cpus"'cpus'
results_path='/home/oracle/results/create/'"$cpus_path"'/results/create'
create_user_script="/skrypty/create/sql/create_user.sql"
create_tables_script="/skrypty/create/sql/create_all.sql"
drop_tables_script="/skrypty/create/sql/drop_all.sql"
mkdir -p $results_path

echo exit | sqlplus sys/Oradoc_db1@ORCLCDB as sysdba @"$create_user_script" > /dev/null 
for i in $(seq 0 $count)
do
    echo "Create iteration: $i"
    if [[ "$i" -eq "0" ]]
    then
        echo exit | sqlplus PERF_TESTS/password@ORCLPDB1 @"$create_tables_script" 
    else
        ( time echo exit | sqlplus PERF_TESTS/password@ORCLPDB1 @"$create_tables_script" > /dev/null ) |& tee "$results_path"'/'"$i"'.txt'
    fi
    echo exit | sqlplus PERF_TESTS/password@ORCLPDB1 @"$drop_tables_script" 
done

