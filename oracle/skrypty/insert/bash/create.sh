#! /bin/bash

create_user_script="/skrypty/insert/sql/create_user.sql"
create_table_script="/skrypty/insert/sql/create.sql"


echo exit | sqlplus sys/Oradoc_db1@ORCLCDB as sysdba @"$create_user_script" 
echo exit | sqlplus PERF_TESTS/password@ORCLPDB1 @"$create_table_script" 