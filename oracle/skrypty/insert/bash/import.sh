#! /bin/bash

logs_path='/home/oracle/results/import'
mkdir -p $logs_path

ctl_file='/skrypty/insert/sql/imports/clients.ctl' 
ctl_file_name='clients'
sqlldr PERF_TESTS/password@ORCLPDB1 control=$ctl_file log="$logs_path/$ctl_file_name"'.log' > /dev/null