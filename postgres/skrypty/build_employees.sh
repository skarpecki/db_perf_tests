#! /bin/bash

cp -r  ../../dane_employees/ ./dane
docker build -t "postgres_srvr" .
rm -r ./dane