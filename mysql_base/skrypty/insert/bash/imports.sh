#! /bin/bash

mysql -u "root" -p$MYSQL_ROOT_PASSWORD < /skrypty/insert/sql/imports/clients.sql
