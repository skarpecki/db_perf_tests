#! /bin/bash

create_index='CREATE INDEX IX_clients ON perf_tests.clients (first_name, last_name);'
echo "$create_index" | sqlplus PERF_TESTS/password@ORCLPDB1 