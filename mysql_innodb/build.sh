#! /bin/bash

cp -r  ../../dane/ .
cp -r ../mysql_base/skrypty/ .
docker build -t "mysql-innodb_srvr" .
rm -r ./dane
rm -r ./skrypty
