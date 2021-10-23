#! /bin/bash

drop_statement="DROP TABLE perf_tests.clients;"
echo $drop_statement | sqlplus PERF_TESTS/password@ORCLPDB1