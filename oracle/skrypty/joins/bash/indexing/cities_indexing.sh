#! /bin/bash

echo "CREATE INDEX IX_cities ON perf_tests.cities (city);" | sqlplus PERF_TESTS/password@ORCLPDB1