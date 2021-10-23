#! /bin/bash

cp -r  ../../dane_employees/ ./dane
cp -r ../mysql_base/skrypty/ .
docker build -t "mysql-myisam_srvr" .
rm -r ./dane
rm -r ./skrypty
