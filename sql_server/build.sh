#! /bin/bash

cp -r  ../../dane/ .
sudo docker build -t "sql_server" .