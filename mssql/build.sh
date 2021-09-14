#! /bin/bash

cp -r  ../../dane/ .
sudo docker build -t "sql_server" .
rm -r ./dane