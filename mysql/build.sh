#! /bin/bash

cp -r  ../../dane/ .
sudo docker build -t "mysql_srvr" .
