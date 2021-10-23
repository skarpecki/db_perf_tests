#! /bin/bash

import_script='/skrypty/insert/sql/imports/clients.sql'
psql --username "postgres" --dbname "perf_tests" -f "$import_script"