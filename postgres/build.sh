#! /bin/bash

cp -r  ../../dane/ .
docker build -t "postgres_srvr" .
rm -r ./dane