#! /bin/bash

create_user_script="/skrypty/group_by_order/sql/create_user.sql"
create_tables_script="/skrypty/group_by_order/sql/create_all.sql"


echo exit | sqlplus sys/Oradoc_db1@ORCLCDB as sysdba @"$create_user_script" 
echo exit | sqlplus PERF_TESTS/password@ORCLPDB1 @"$create_tables_script" 