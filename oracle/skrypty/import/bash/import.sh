#! /bin/bash

results_path="/home/oracle/results/import"
create_user_script="/skrypty/import/sql/create_user.sql"
create_tables_script="/skrypty/import/sql/create_all.sql"
truncate_tables_script="/skrypty/import/sql/truncate_all.sql"
mkdir -p $results_path

count=$1
echo exit | sqlplus sys/Oradoc_db1@ORCLCDB as sysdba @"$create_user_script" > /dev/null 
echo exit | sqlplus PERF_TESTS/password@ORCLPDB1 @"$create_tables_script" 
for i in $(seq 0 $count)
do
    echo "Import iteration: $i"
    for ctl_file in /skrypty/import/sql/imports/*.ctl
    do
        ctl_file_name=$(basename $ctl_file .ctl)
        if [[ "$i" -eq "0" ]]
        then
            sqlldr PERF_TESTS/password@ORCLPDB1 control=$ctl_file log='/home/oracle/results/'"$ctl_file_name"'.log' skip_index_maintenance=true  direct=true  parallel=true
        else
            ( time sqlldr PERF_TESTS/password@ORCLPDB1 control=$ctl_file skip_index_maintenance=true  direct=true  parallel=true > /dev/null ) |& tee "$results_path"'/'"$i"'.txt'
        fi
    done
    echo exit | sqlplus PERF_TESTS/password@ORCLPDB1 @"$truncate_tables_script" 
done

