#! /bin/bash


for ctl_file in /skrypty/sql/imports/*.ctl
do
ctl_file_name=$(basename $ctl_file .sql)
mkdir -p /home/oracle/results/imports
   ( time sqlldr PERF_TESTS/password@ORCLPDB1 control=$ctl_file skip_index_maintenance=true  direct=true  parallel=true > /dev/null ) |& tee /home/oracle/results/imports/$ctl_file_name.txt
done


