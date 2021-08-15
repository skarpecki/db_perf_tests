#! /bin/bash

cp -r  ../../dane/ .
sudo docker build -t "oracle_srvr" .
rm -r ./dane