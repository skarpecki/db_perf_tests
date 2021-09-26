#! /bin/bash

echo "CREATE INDEX IX_companies ON perf_tests.companies (name, sector);" | sqlplus PERF_TESTS/password@ORCLPDB1