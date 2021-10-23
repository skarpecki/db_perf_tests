#! /bin/bash

cp -r  ../../dane_employees/ ./dane
docker build -t "mssql_srvr" .
rm -r ./dane
