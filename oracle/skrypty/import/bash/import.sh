#! /bin/bash

count=$1
cpus=$2

cpus_path='results_'"$cpus"'cpus'
create_user_script="/skrypty/import/sql/create_user.sql"
create_tables_script="/skrypty/import/sql/create_all.sql"
truncate_tables_script="/skrypty/import/sql/truncate_all.sql"
drop_tables_script="/skrypty/import/sql/drop_all.sql"

echo exit | sqlplus sys/Oradoc_db1@ORCLCDB as sysdba @"$create_user_script" > /dev/null 
for i in $(seq 0 $count)
do
    echo "Import iteration: $i"
    echo exit | sqlplus PERF_TESTS/password@ORCLPDB1 @"$create_tables_script" 
    for ctl_file in /skrypty/import/sql/imports/*.ctl
    do
        ctl_file_name=$(basename $ctl_file .ctl)
        results_path='/home/oracle/results/import/'"$cpus_path"'/results/import/'"$ctl_file_name"
        logs_path='/home/oracle/results/import/'"$cpus_path"'/results/import/import_logs'
        mkdir -p "$results_path"
	    mkdir -p "$logs_path"
	    if [[ "$i" -eq "0" ]]
            then
                sqlldr PERF_TESTS/password@ORCLPDB1 control=$ctl_file log="$logs_path"'/'"$ctl_file_name"'.log' skip_index_maintenance=true  direct=true  parallel=true
            else
                ( time sqlldr PERF_TESTS/password@ORCLPDB1 control=$ctl_file skip_index_maintenance=true  direct=true  parallel=true > /dev/null ) |& tee "$results_path"'/'"$i"'.txt'
        fi
    done
    echo exit | sqlplus PERF_TESTS/password@ORCLPDB1 @"$drop_tables_script" 
done

