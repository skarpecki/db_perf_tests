#! /bin/bash

cpus_path='results_'"$cpus"'cpus'
logs_path='/home/oracle/results/log/'"$cpus_path"'/results/import_logs'
mkdir -p $logs_path

for ctl_file in /skrypty/import/sql/imports/*.ctl
do
    ctl_file_name=$(basename $ctl_file .ctl)
    sqlldr PERF_TESTS/password@ORCLPDB1 control=$ctl_file log="$logs_path"'/'"$ctl_file_name"'.log' skip_index_maintenance=true  direct=true  parallel=true    
done