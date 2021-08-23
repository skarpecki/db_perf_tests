#! /bin/bash

mkdir -p /home/oracle/results/creates/
echo exit | sqlplus sys/Oradoc_db1@ORCLCDB as sysdba @/skrypty/sql/create_user.sql > /dev/null 
( time echo exit | sqlplus PERF_TESTS/password@ORCLPDB1 @/skrypty/sql/create_all.sql > /dev/null ) |& tee /home/oracle/results/creates/creates.txt

