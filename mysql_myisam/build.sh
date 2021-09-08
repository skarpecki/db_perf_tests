#! /bin/bash

cp -r ../mysql_base/skrypty/ .
cp -r  ../../dane/ .
docker build -t "mysql-myisam_srvr" .
rm -r ./dane
rm -r ./skrypty
