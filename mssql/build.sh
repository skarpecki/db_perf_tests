#! /bin/bash

cp -r  ../../dane/ .
docker build -t "mssql_srvr" .
rm -r ./dane
