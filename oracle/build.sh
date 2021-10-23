#! /bin/bash

cp -r  ../../dane/ .
docker build -t "oracle_srvr" .
rm -r ./dane