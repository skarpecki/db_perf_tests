#! /bin/bash

cp -r  ../../dane/ .
sudo docker build -t "mssql_srvr" .
rm -r ./dane