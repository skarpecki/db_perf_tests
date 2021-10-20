#! /bin/bash
cpus=1

create_user_script="/skrypty/create_user.sql"
drop_tables_script="/skrypty/drop_all.sql"

echo exit | sqlplus sys/Oradoc_db1@ORCLCDB as sysdba @"$create_user_script" 
sleep 30

/skrypty/create/run.sh

sleep 30

/skrypty/import/run.sh
echo exit | sqlplus PERF_TESTS/password@ORCLPDB1 @"$drop_tables_script" 

#/skrypty/insert/run.sh
#echo exit | sqlplus PERF_TESTS/password@ORCLPDB1 @"$drop_tables_script" 

/skrypty/index/run.sh
echo exit | sqlplus PERF_TESTS/password@ORCLPDB1 @"$drop_tables_script" 

/skrypty/log/run.sh
echo exit | sqlplus PERF_TESTS/password@ORCLPDB1 @"$drop_tables_script" 

# /skrypty/joins/run.sh
# echo exit | sqlplus PERF_TESTS/password@ORCLPDB1 @"$drop_tables_script"