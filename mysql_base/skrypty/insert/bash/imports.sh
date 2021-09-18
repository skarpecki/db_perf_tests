#! /bin/bash

mkdir -p /results/import/
( time mysql -u "root" -p$MYSQL_ROOT_PASSWORD < /skrypty/insert/sql/imports/clients.sql  &> /dev/null ) |& tee /results/import/imports.txt
