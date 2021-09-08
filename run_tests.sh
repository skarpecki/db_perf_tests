#!/bin/bash

cd mysql_innodb
./run_tests.sh
echo $(pwd)
cd ..
sleep 20
cd mysql_myisam
./run_tests.sh
cd ..
sleep 20

