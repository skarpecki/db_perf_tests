#! /bin/bash

cp -r  ../../dane_employees/ ./dane_employees
docker build -t "oracle_srvr" .
rm -r ./dane