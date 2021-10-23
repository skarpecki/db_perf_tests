#! /bin/bash

echo "CREATE INDEX IX_orders ON perf_tests.orders (part_num);" | sqlplus PERF_TESTS/password@ORCLPDB1