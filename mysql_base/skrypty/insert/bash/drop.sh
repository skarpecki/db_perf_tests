#! /bin/bash

drop_statement="DROP TABLE IF EXISTS perf_tests.clients;"
mysql -u "root" -p$MYSQL_ROOT_PASSWORD -e "$drop_statement"  