#! /bin/bash

mkdir -p /results/imports/
( time /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P  $SA_PASSWORD -i /skrypty/insert/sql/imports/clients.sql  > /dev/null ) \
    |& tee /results/imports/imports.txt