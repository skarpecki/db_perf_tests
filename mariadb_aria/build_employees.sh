#! /bin/bash

cp -r  ../../dane_employees/ ./dane
cp -r ../mysql_base/skrypty/ .
docker build -t "mariadb-aria_srvr" .
rm -r ./dane
rm -r ./skrypty
