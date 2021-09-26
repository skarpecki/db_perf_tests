#! /bin/bash

echo "CREATE INDEX IX_clients ON perf_tests.clients (first_name, last_name);" | sqlplus PERF_TESTS/password@ORCLPDB1