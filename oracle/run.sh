#!/bin/bash

sudo docker run --name="oracle_srvr" --cpus=1 --memory="8G" -p 1521:1521 -p 5500:5500 -v oracle_vol:/ORCL -d oracle_srvr
