#! /bin/bash

cp -r  ../../dane_employees/ ./dane
docker build -t "oracle_srvr" .
rm -r ./dane
